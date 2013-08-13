VIRSH_URI=qemu:///system
VIRSH_DOMAIN=scebuild
VIRSH_RESET_SNAPSHOT=clean-base-7
VMHOST=chandra
IDENT_HOST=chandra
SSH=ssh root@$(VMHOST) -i ~/.ssh/$(IDENT_HOST)
SCP=scp -i ~/.ssh/$(IDENT_HOST)
DFDIR=distfiles
GETCMD=aria2c --conditional-get=true --dir=$(DFDIR)
RSYNC=rsync -az

LOCAL_PORTAGE=/usr/local/portage
EBUILD_PREFIX=logitechmediaserver-bin
EBUILD_CATEGORY2=media-sound
EBUILD_CATEGORY=$(EBUILD_CATEGORY2)/$(EBUILD_PREFIX)
EBUILD_DIR=$(LOCAL_PORTAGE)/$(EBUILD_CATEGORY)
STAGEDIR=$(EBUILD_CATEGORY)
OVERLAY_DIR=$(HOME)/code/gentoo/squeezebox-overlay
GPG_KEYID=6C0371E6

PS=patch_source
PD=patch_dest

# PATCH_PV is the version that our diff patch is produced against. This allows
# me to send Joe a patch that shows the changes I have made in just the stage
# directory (ie ignoring all the ebuild generation crud and concentrating on
# what would be in the portage tree).
PATCH_PV=7.7.2-4

PV=7.7.3
R=_alpha1
R=_alpha2
BUILD_NUM=1372939239
P1=logitechmediaserver-bin-$(PV)
P2=logitechmediaserver-bin-$(PV)$(R)
P=logitechmediaserver
DF=$(P)-$(PV)-${BUILD_NUM}.tgz
SRC_URI=http://downloads.slimdevices.com/LogitechMediaServer_Perl5.16/$(P)-$(PV)-${BUILD_NUM}.tgz
P_BUILD_NUM=$(P)-$(PV)-$(BUILD_NUM)
EB=$(P1)$(R).ebuild

FILES=logitechmediaserver.init.d \
	  logitechmediaserver.conf.d \
	  logitechmediaserver.logrotate.d \
	  Gentoo-plugins-README.txt \
	  Gentoo-detailed-changelog.txt \
	  gentoo-filepaths.pm

all: inject

# Produce a patch I can send to Joe. This produces differences just for the
# stage directory so this concentrates on the changes needed to the portage
# folder only. This diffs the working tree's stage folder against a previous
# formal git tag, so it first makes sure the stage folder reflects the
# current working tree's version of the ebuild and the patches are generated
# etc.
portagepatch:
	make $(STAGEDIR) >/dev/null
	git diff --patch --stat $(PATCH_PV) -- $(STAGEDIR)

prebuiltfiles.txt: $(DFDIR)/$(DF)
	echo "Identifying prebuilt binaries in distfile"
	./mkprebuilt $^ $(P_BUILD_NUM) opt/logitechmediaserver >$@

stage: patches prebuiltfiles.txt
	#-rm -r $(STAGEDIR)
	#mkdir -p $(STAGEDIR)/files
	cp metadata.xml $(STAGEDIR)
	cp files/* $(STAGEDIR)/files
	cp patch_dest/* $(STAGEDIR)/files
	A=`grep '$$Id' $(STAGEDIR)/files/*.patch | wc -l`; [ $$A -eq 0 ]
	sed -e "/@@QA_PREBUILT@@/r prebuiltfiles.txt" -e "/@@QA_PREBUILT@@/d" < "$(EB).in" >"$(STAGEDIR)/$(EB)"
	(cd $(STAGEDIR); ebuild `ls *.ebuild | head -n 1` manifest)

inject: stage inject_distfiles
	echo Injecting ebuilds...
	$(SSH) "rm -r $(EBUILD_DIR)/* >/dev/null 2>&1 || true"
	$(SSH) mkdir -p $(EBUILD_DIR)
	$(SCP) -r $(STAGEDIR)/* root@$(VMHOST):$(EBUILD_DIR)
	echo Unmasking ebuild...
	$(SSH) mkdir -p /etc/portage
	$(SCP) package.keywords package.use package.unmask root@$(VMHOST):/etc/portage

overlay: stage
	# The following ensures our overlay project is on a feature branch
	(cd "$(OVERLAY_DIR)"; [[ `git rev-parse --abbrev-ref HEAD` == feature/* ]])
	-rm -rf "$(OVERLAY_DIR)/$(EBUILD_CATEGORY)" 2>/dev/null
	cp -r "$(STAGEDIR)" "$(OVERLAY_DIR)/$(EBUILD_CATEGORY2)"
	#(cd "$(OVERLAY_DIR)/$(EBUILD_CATEGORY)"; gpg --clearsign --default-key $(GPG_KEYID) Manifest; mv Manifest.asc Manifest)

inject_distfiles: $(DFDIR)/$(DF)
	$(RSYNC) $^ root@$(VMHOST):/usr/portage/distfiles

$(DFDIR)/$(DF):
	$(GETCMD) "$(SRC_URI)"

vmreset:
	echo Resetting VM...
	virsh --connect $(VIRSH_URI) snapshot-revert $(VIRSH_DOMAIN) $(VIRSH_RESET_SNAPSHOT)

vmstart:
	echo Starting VM...
	-virsh --connect $(VIRSH_URI) start $(VIRSH_DOMAIN)
	sleep 1
	while ! ping -w1 -q $(VMHOST); do echo Waiting for host to come up...; sleep 1; done
	echo Host up... Waiting for SSH server to start
	sleep 10
	ssh root@chandra

vmstop:
	echo Stopping VM...
	-virsh --connect $(VIRSH_URI) shutdown $(VIRSH_DOMAIN)

uninstall:
	-$(SSH) /etc/init.d/logitechmediaserver stop
	-$(SSH) emerge --unmerge logitechmediaserver-bin
	-$(SSH) rm -fr /etc/init.d/logitechmediaserver /etc/conf.d/logitechmediaserver /etc/logrotate.d/logitechmediaserver
	-$(SSH) rm -fr /etc/logitechmediaserver /var/log/logitechmediaserver /var/lib/logitechmediaserver /opt/logitechmediaserver

patches: $(PD)/$(P2)-client-playlists-gentoo.patch $(PD)/$(P2)-uuid-gentoo.patch

$(PD)/$(P2)-uuid-gentoo.patch: $(PS)/slimserver.pl
	./mkpatch $@ $^

$(PD)/$(P2)-client-playlists-gentoo.patch: $(PS)/Slim/Player/Playlist.pm
	./mkpatch $@ $^
