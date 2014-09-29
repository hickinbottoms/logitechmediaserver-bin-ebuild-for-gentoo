VIRSH_URI=qemu:///system
VIRSH_DOMAIN=scebuild
VIRSH_RESET_SNAPSHOT=clean-base-6
VMHOST=chandra
IDENT_HOST=chandra
SSH=ssh root@$(VMHOST) -i ~/.ssh/$(IDENT_HOST)
SCP=scp -i ~/.ssh/$(IDENT_HOST)
DFDIR=distfiles
GETCMD=aria2c --conditional-get=true --check-certificate=false --dir=$(DFDIR)
RSYNC=rsync -a -e "ssh -i /home/stuarth/.ssh/${IDENT_HOST}"

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

PV=7.9.0
R=_pre20140928
COMMIT=c05d9360b3d2141eaa2083237243777f8dd1cb42
P=logitechmediaserver-bin
P1=$(P)-$(PV)
P2=$(P)-$(PV)$(R)
SRC_URI=https://github.com/Logitech/slimserver/archive/$(COMMIT).zip
EB=$(P1)$(R).ebuild
EB9999=$(P)-9999.ebuild

FILES=logitechmediaserver.init.d \
	  logitechmediaserver.conf.d \
	  logitechmesiaserver.service \
	  logitechmediaserver.logrotate.d \
	  Gentoo-plugins-README.txt \
	  Gentoo-detailed-changelog.txt \
	  gentoo-filepaths.pm

all: inject

prebuiltfiles.txt: $(DFDIR)/$(COMMIT).zip
	echo "Identifying prebuilt binaries in distfile"
	./mkprebuilt $^ "slimserver-$(COMMIT)" opt/logitechmediaserver >$@

stage: patches prebuiltfiles.txt
	#-rm -r $(STAGEDIR)
	mkdir -p $(STAGEDIR)/files
	cp metadata.xml $(STAGEDIR)
	cp files/* $(STAGEDIR)/files
	cp patch_dest/* $(STAGEDIR)/files
	A=`grep '$$Id' $(STAGEDIR)/files/*.patch | wc -l`; [ $$A -eq 0 ]
	sed -e "/@@QA_PREBUILT@@/r prebuiltfiles.txt" -e "/@@QA_PREBUILT@@/d" < "$(EB).in" >"$(STAGEDIR)/$(EB)"
	sed -e "s/@@QA_PREBUILT@@/*/" < "$(EB).in" >"$(STAGEDIR)/$(EB9999)"
	-rm $(STAGEDIR)/Manifest
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

inject_distfiles:
	$(RSYNC) $(DFDIR)/ root@$(VMHOST):/usr/portage/distfiles

$(DFDIR)/$(COMMIT).zip: 
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
