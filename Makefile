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
EBUILD_CATEGORY=media-sound/$(EBUILD_PREFIX)
EBUILD_DIR=$(LOCAL_PORTAGE)/$(EBUILD_CATEGORY)

PS=patch_source
PD=patch_dest

# PATCH_PV is the version that our diff patch is produced against. This allows
# me to send Joe a patch that shows the changes I have made in just the stage
# directory (ie ignoring all the ebuild generation crud and concentrating on
# what would be in the portage tree).
PATCH_PV=7.7.2

PV=7.7.2
R=
BUILD_NUM=33893
P1=logitechmediaserver-bin-$(PV)
P=logitechmediaserver
DF=$(P)-$(PV).tgz
SRC_URI=http://downloads.slimdevices.com/LogitechMediaServer_v$(PV)/$(P)-$(PV).tgz
SRC_DIR=LogitechMediaServer_v$(PV)
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
	make stage >/dev/null
	git diff --patch --stat $(PATCH_PV) -- stage

prebuiltfiles.txt: $(DFDIR)/$(DF)
	echo "Identifying prebuilt binaries in distfile"
	./mkprebuilt $^ $(P_BUILD_NUM) opt/logitechmediaserver >$@

stage: patches prebuiltfiles.txt
	-rm -r stage/*
	mkdir stage/files
	cp metadata.xml stage
	cp files/* stage/files
	cp patch_dest/* stage/files
	A=`grep '$$Id' stage/files/*.patch | wc -l`; [ $$A -eq 0 ]
	sed -e "/@@QA_PREBUILT@@/r prebuiltfiles.txt" -e "/@@QA_PREBUILT@@/d" < "$(EB).in" >"stage/$(EB)"

inject: stage inject_distfiles
	echo Injecting ebuilds...
	$(SSH) "rm -r $(EBUILD_DIR)/* >/dev/null 2>&1 || true"
	$(SSH) mkdir -p $(EBUILD_DIR) $(EBUILD_DIR)/files
	$(SCP) metadata.xml root@$(VMHOST):$(EBUILD_DIR)
	$(SCP) stage/$(EB) root@$(VMHOST):$(EBUILD_DIR)
	(cd files; $(SCP) $(FILES) root@$(VMHOST):$(EBUILD_DIR)/files)
	(cd patch_dest; $(SCP) *.patch root@$(VMHOST):$(EBUILD_DIR)/files)
	$(SSH) 'cd $(EBUILD_DIR); ebuild `ls *.ebuild | head -n 1` manifest'
	echo Unmasking ebuild...
	$(SSH) mkdir -p /etc/portage
	$(SCP) package.keywords package.use package.unmask root@$(VMHOST):/etc/portage

inject_distfiles: $(DFDIR)/$(DF)
	$(RSYNC) $^ root@$(VMHOST):/usr/portage/distfiles

$(DFDIR)/$(DF):
	$(GETCMD) "$(SRC_URI)"

vmreset:
	echo Resetting VM...
	sudo virsh snapshot-revert $(VIRSH_DOMAIN) $(VIRSH_RESET_SNAPSHOT)

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

patches: $(PD)/$(P1)-uuid-gentoo.patch

$(PD)/$(P1)-uuid-gentoo.patch: $(PS)/slimserver.pl
	./mkpatch $@ $^

