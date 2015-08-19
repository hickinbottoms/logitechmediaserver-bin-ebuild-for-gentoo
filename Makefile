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
R=_pre20150812
COMMIT=c17601c5892eaac40a359d1392e454ad5c69db9d
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

all: stage

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

overlay: stage
	# The following ensures our overlay project is on a feature branch
	(cd "$(OVERLAY_DIR)"; [[ `git rev-parse --abbrev-ref HEAD` == feature/* || `git rev-parse --abbrev-ref HEAD` == hotfix/* ]])
	rsync -a --delete $(EBUILD_CATEGORY) $(OVERLAY_DIR)/$(EBUILD_CATEGORY2)
	#-rm -rf "$(OVERLAY_DIR)/$(EBUILD_CATEGORY)" 2>/dev/null
	#cp -r "$(STAGEDIR)" "$(OVERLAY_DIR)/$(EBUILD_CATEGORY2)"
	#(cd "$(OVERLAY_DIR)/$(EBUILD_CATEGORY)"; gpg --clearsign --default-key $(GPG_KEYID) Manifest; mv Manifest.asc Manifest)

$(DFDIR)/$(COMMIT).zip: 
	$(GETCMD) "$(SRC_URI)"   

patches: $(PD)/$(P2)-client-playlists-gentoo.patch $(PD)/$(P2)-uuid-gentoo.patch

$(PD)/$(P2)-uuid-gentoo.patch: $(PS)/slimserver.pl
	./mkpatch $@ $^

$(PD)/$(P2)-client-playlists-gentoo.patch: $(PS)/Slim/Player/Playlist.pm
	./mkpatch $@ $^
