VIRSH_URI=qemu:///system
VIRSH_DOMAIN=scebuild
VIRSH_RESET_SNAPSHOT=clean-base-4
VMHOST=chandra
IDENT_HOST=chandra
SSH=ssh root@$(VMHOST) -i ~/.ssh/$(IDENT_HOST)
SCP=scp -i ~/.ssh/$(IDENT_HOST)

LOCAL_PORTAGE=/usr/local/portage
EBUILD_PREFIX=logitechmediaserver-bin
EBUILD_CATEGORY=media-sound/$(EBUILD_PREFIX)
EBUILD_DIR=$(LOCAL_PORTAGE)/$(EBUILD_CATEGORY)

PS=patch_source
PD=patch_dest

PV=7.7.2
P1=logitechmediaserver-bin-$(PV)

FILES=logitechmediaserver.init.d \
	  logitechmediaserver.conf.d \
	  logitechmediaserver.logrotate.d \
	  Gentoo-plugins-README.txt \
	  Gentoo-detailed-changelog.txt

all: inject

stage: patches
	-rm -r stage/*
	mkdir stage/files
	cp metadata.xml *.ebuild stage
	cp files/* stage/files
	cp patch_dest/* stage/files
	A=`grep '$$Id' stage/files/*.patch | wc -l`; [ $$A -eq 0 ]

inject: stage
	echo Injecting ebuilds...
	$(SSH) "rm -r $(EBUILD_DIR)/* >/dev/null 2>&1 || true"
	$(SSH) mkdir -p $(EBUILD_DIR) $(EBUILD_DIR)/files
	$(SCP) metadata.xml *.ebuild root@$(VMHOST):$(EBUILD_DIR)
	(cd files; $(SCP) $(FILES) root@$(VMHOST):$(EBUILD_DIR)/files)
	(cd patch_dest; $(SCP) *.patch root@$(VMHOST):$(EBUILD_DIR)/files)
	$(SSH) 'cd $(EBUILD_DIR); ebuild `ls *.ebuild | head -n 1` manifest'
	echo Unmasking ebuild...
	$(SSH) mkdir -p /etc/portage
	$(SCP) package.keywords package.use package.unmask root@$(VMHOST):/etc/portage

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
	-$(SSH) rm -fr /var/log/logitechmediaserver /var/opt/logitechmediaserver /etc/logitechmediaserver

patches: $(PD)/$(P1)-uuid-gentoo.patch

$(PD)/$(P1)-uuid-gentoo.patch: $(PS)/slimserver.pl
	./mkpatch $@ $^
