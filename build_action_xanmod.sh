#!/usr/bin/env bash

VERSION=$(grep 'Kernel Configuration' < config | awk '{print $3}')

# add deb-src to sources.list
sed -i "/deb-src/s/# //g" /etc/apt/sources.list

# install dep
sudo apt update
sudo apt install -y wget xz-utils make gcc-12 flex bison dpkg-dev bc rsync kmod cpio libssl-dev git lsb vim libelf-dev
sudo apt build-dep -y linux

# change dir to workplace
cd "${GITHUB_WORKSPACE}" || exit

# download kernel source
wget https://gitlab.com/xanmod/linux/-/archive/6.1.39-xanmod1/linux-6.1.39-xanmod1.tar.gz
tar -xf linux-6.1.38-rt12-xanmod1.tar.gz
cd linux-6.1.38-rt12-xanmod1|| exit

# copy config file
cp ../configut .config

# disable DEBUG_INFO to speedup build
scripts/config --set-str SYSTEM_TRUSTED_KEYS ""
scripts/config --set-str SYSTEM_REVOCATION_KEYS ""
scripts/config --undefine DEBUG_INFO
scripts/config --undefine DEBUG_INFO_COMPRESSED
scripts/config --undefine DEBUG_INFO_REDUCED
scripts/config --undefine DEBUG_INFO_SPLIT
scripts/config --undefine GDB_SCRIPTS
scripts/config --set-val  DEBUG_INFO_DWARF5     n
scripts/config --set-val  DEBUG_INFO_NONE       y

# apply patches
# shellcheck source=src/util.sh
# source ../patch.d/*.sh

# build deb packages
CPU_CORES=$(($(grep -c processor < /proc/cpuinfo)*2))
sudo make bindeb-pkg -j"$CPU_CORES"

# move deb packages to artifact dir
cd ..
rm -rfv *dbg*.deb
mkdir "artifact"
mv ./*.deb artifact/
