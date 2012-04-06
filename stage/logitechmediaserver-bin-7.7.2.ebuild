# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="3"

inherit eutils

BUILD_NUM="33893"
SRC_DIR="LogitechMediaServer_v${PV}"
MY_PN="${PN/-bin}"
MY_P_BUILD_NUM="${MY_PN}-${PV}-${BUILD_NUM}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Logitech Meda Server music server"
HOMEPAGE="http://www.mysqueezebox.com/download"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_URI="http://downloads.slimdevices.com/${SRC_DIR}/${MY_P}.tgz"

# Installation dependencies.
DEPEND="
	!media-sound/squeezecenter
	!media-sound/squeezeboxserver
	"

# Runtime dependencies.
RDEPEND="
	!prefix? ( >=sys-apps/baselayout-2.0.0 )
	!prefix? ( virtual/logger )
	>=dev-lang/perl-5.8.8[ithreads]
	>=dev-perl/Data-UUID-1.202
	"

# This is a binary package and contains prebuilt executable and library
# files. We need to identify those to suppress the QA warnings during
# installation.
QA_PREBUILT="
	opt/logitechmediaserver/Bin/i386-freebsd-64int/faad
	opt/logitechmediaserver/Bin/i386-freebsd-64int/flac
	opt/logitechmediaserver/Bin/i386-freebsd-64int/mac
	opt/logitechmediaserver/Bin/i386-freebsd-64int/sls
	opt/logitechmediaserver/Bin/i386-freebsd-64int/wvunpack
	opt/logitechmediaserver/Bin/arm-linux/faad
	opt/logitechmediaserver/Bin/arm-linux/flac
	opt/logitechmediaserver/Bin/arm-linux/sox
	opt/logitechmediaserver/Bin/arm-linux/mac
	opt/logitechmediaserver/Bin/arm-linux/sls
	opt/logitechmediaserver/Bin/arm-linux/wvunpack
	opt/logitechmediaserver/Bin/i386-linux/faad
	opt/logitechmediaserver/Bin/i386-linux/flac
	opt/logitechmediaserver/Bin/i386-linux/sox
	opt/logitechmediaserver/Bin/i386-linux/mac
	opt/logitechmediaserver/Bin/i386-linux/mppdec
	opt/logitechmediaserver/Bin/i386-linux/sls
	opt/logitechmediaserver/Bin/i386-linux/wvunpack
	opt/logitechmediaserver/Bin/darwin/faad
	opt/logitechmediaserver/Bin/darwin/flac
	opt/logitechmediaserver/Bin/darwin/sox
	opt/logitechmediaserver/Bin/darwin/mac
	opt/logitechmediaserver/Bin/darwin/sls
	opt/logitechmediaserver/Bin/darwin/wvunpack
	opt/logitechmediaserver/Bin/sparc-linux/faad
	opt/logitechmediaserver/Bin/sparc-linux/aac2wav
	opt/logitechmediaserver/Bin/sparc-linux/mp42aac
	opt/logitechmediaserver/Bin/sparc-linux/alac
	opt/logitechmediaserver/Bin/powerpc-linux/faad
	opt/logitechmediaserver/Bin/powerpc-linux/flac
	opt/logitechmediaserver/Bin/powerpc-linux/sox
	opt/logitechmediaserver/Bin/powerpc-linux/mac
	opt/logitechmediaserver/Bin/powerpc-linux/wvunpack
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.14/arm-linux-gnueabi-thread-multi-64int/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.14/powerpc-linux-thread-multi-64int/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/Class/C3/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-freebsd-64int/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Class/C3/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/Class/C3/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.8/arm-linux-gnueabi-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/Class/C3/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.8/powerpc-linux-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/Class/C3/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.8/sparc-linux/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Class/C3/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.12/arm-linux-gnueabi-thread-multi-64int/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.12/powerpc-linux-thread-multi-64int/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.10/arm-linux-gnueabi-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.10/powerpc-linux-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/DBI/DBI.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/EV/EV.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Font/FreeType/FreeType.so
	opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
"

S="${WORKDIR}/${MY_P_BUILD_NUM}"

RUN_UID=logitechmediaserver
RUN_GID=logitechmediaserver

OPTDIR="/opt/${MY_PN}"
RUNDIR="/var/run/${MY_PN}"
VARDIR="/var/lib/${MY_PN}"
CACHEDIR="${VARDIR}/cache"
PLUGINSDIR="${VARDIR}/Plugins"
PREFSDIR="/etc/${MY_PN}"
LOGDIR="/var/log/${MY_PN}"

pkg_setup() {
	# Create the user and group if not already present
	enewgroup ${RUN_GID}
	enewuser ${RUN_UID} -1 -1 "/dev/null" ${RUN_GID}
}

src_prepare() {
	# Apply patches
	epatch "${FILESDIR}/${P}-uuid-gentoo.patch"
}

src_install() {

	# The custom OS module for Gentoo - provides OS-specific path details
	cp "${FILESDIR}/gentoo-filepaths.pm" "Slim/Utils/OS/Custom.pm" || die "Unable to install Gentoo custom OS module"

	# Everthing into our package in the /opt hierarchy (LHS)
	dodir "${OPTDIR}"
	cp -aR "${S}"/* "${ED}${OPTDIR}" || die "Unable to install package files"

	# Documentation
	dodoc Changelog*.html
	dodoc Installation.txt
	dodoc License*.txt
	dodoc "${FILESDIR}/Gentoo-plugins-README.txt"
	dodoc "${FILESDIR}/Gentoo-detailed-changelog.txt"

	# Preferences directory
	dodir "${PREFSDIR}"
	fowners ${RUN_UID}:${RUN_GID} "${PREFSDIR}"
	fperms 770 "${PREFSDIR}"

	# Install init scripts
	newconfd "${FILESDIR}/logitechmediaserver.conf.d" "${MY_PN}"
	newinitd "${FILESDIR}/logitechmediaserver.init.d" "${MY_PN}"

	# Initialize run directory (where the PID file lives)
	dodir "${RUNDIR}"
	fowners ${RUN_UID}:${RUN_GID} "${RUNDIR}"
	fperms 770 "${RUNDIR}"

	# Initialize server cache directory
	dodir "${CACHEDIR}"
	fowners ${RUN_UID}:${RUN_GID} "${CACHEDIR}"
	fperms 770 "${CACHEDIR}"

	# Initialize the log directory
	dodir "${LOGDIR}"
	fowners ${RUN_UID}:${RUN_GID} "${LOGDIR}"
	fperms 770 "${LOGDIR}"
	touch "${ED}/${LOGDIR}/server.log"
	touch "${ED}/${LOGDIR}/scanner.log"
	touch "${ED}/${LOGDIR}/perfmon.log"
	fowners ${RUN_UID}:${RUN_GID} "${LOGDIR}/server.log"
	fowners ${RUN_UID}:${RUN_GID} "${LOGDIR}/scanner.log"
	fowners ${RUN_UID}:${RUN_GID} "${LOGDIR}/perfmon.log"

	# Initialise the user-installed plugins directory
	dodir "${PLUGINSDIR}"
	fowners ${RUN_UID}:${RUN_GID} "${PLUGINSDIR}"
	fperms 770 "${PLUGINSDIR}"

	# Install logrotate support
	insinto /etc/logrotate.d
	newins "${FILESDIR}/logitechmediaserver.logrotate.d" "${MY_PN}"
}

pkg_postinst() {
	einfo ""
	einfo "Manually installed plugins should be placed in the following directory:"
	einfo " ${PLUGINSDIR}"
	einfo ""
}
