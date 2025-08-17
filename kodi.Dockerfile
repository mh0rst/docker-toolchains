# Ubuntu based kodi build image
# For https://github.com/xbmc/xbmc, tested with master, commit 27b156a54a8222aaa957b6d96e993706140729fb
FROM ubuntu:latest

WORKDIR /work

RUN apt update && apt install -y build-essential gdb

# Omitted crossguid, flatbuffers libfmt, libspdlog, wayland-protocols waylandpp
# Added pugixml, scons, libexiv2-dev, libwayland-dev libwayland-egl1-mesa, libtinyxml2-dev, libdrm-dev
# Replaced libcdio-dev with libcdio++-dev
RUN apt install -y autoconf automake autopoint autotools-dev \
    cmake cpp curl g++ gawk gcc gdc \
    gettext gperf libasound2-dev libass-dev \
    libavahi-client-dev libavahi-common-dev libbluetooth-dev libbluray-dev \
    libbz2-dev libcdio++-dev libcec-dev \
    libcurl4-openssl-dev libcwiid-dev libdbus-1-dev libdrm-dev libegl1-mesa-dev \
    libenca-dev libexif-dev libexiv2-dev libflac-dev \
    libfontconfig-dev libfreetype-dev libfribidi-dev libfstrcmp-dev \
    libgcrypt20-dev libgif-dev libgl1-mesa-dev libglew-dev \
    libglu1-mesa-dev libgnutls28-dev libgpg-error-dev libgtest-dev \
    libiso9660-dev libjpeg-dev liblcms2-dev liblirc-dev \
    libltdl-dev liblzo2-dev libmicrohttpd-dev libmysqlclient-dev \
    libnfs-dev libogg-dev libp8-platform-dev libpcre2-dev \
    libplist-dev libpng-dev libpugixml-dev libpulse-dev libshairplay-dev \
    libsmbclient-dev libsqlite3-dev libssl-dev \
    libtag1-dev libtiff5-dev libtinyxml-dev libtinyxml2-dev libtool \
    libudev-dev libunistring-dev libva-dev libvdpau-dev \
    libvorbis-dev libwayland-dev libwayland-egl1-mesa libxkbcommon-dev \
    libxmu-dev libxrandr-dev libxslt1-dev libxt-dev lsb-release meson \
    nasm netcat-traditional ninja-build nlohmann-json3-dev \
    openjdk-21-jre python3-dev python3-minimal python3-pil \
    scons swig unzip uuid-dev wipe zip zlib1g-dev

RUN mkdir kodi
ADD ./tools/depends dependencies
RUN cd dependencies && \
    make -j`nproc` -C target/crossguid PREFIX=/usr/local && \
	make -j`nproc` -C target/flatbuffers PREFIX=/usr/local && \
	make -j`nproc` -C target/fmt PREFIX=/usr/local && \
	make -j`nproc` -C target/spdlog PREFIX=/usr/local && \
	make -j`nproc` -C target/wayland-protocols PREFIX=/usr/local; \
	make -j`nproc` -C target/waylandpp PREFIX=/usr/local || \
	make -j`nproc` -C target/waylandpp PREFIX=/usr/local
# Somehow first waylandpp build fails, second succeeds...

WORKDIR /work/kodi

ENTRYPOINT ["/bin/bash"]
