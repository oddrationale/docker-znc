#!/bin/bash
#
# Build ZNC from source and clean up build dependencies
#

# Install build dependencies
apt-get update
apt-get -y install build-essential libssl-dev libperl-dev pkg-config

# Build ZNC
cd /tmp
tar -xzvf znc*.*gz
cd znc*
./configure
make
make install

# Remove build dependencies and source files
apt-get -y purge binutils build-essential cpp cpp-4.8 dpkg-dev fakeroot \
    g++ g++-4.8 gcc gcc-4.8 libalgorithm-diff-perl libalgorithm-diff-xs-perl \
    libalgorithm-merge-perl libasan0 libatomic1 libc-dev-bin libc6-dev \
    libcloog-isl4 libdpkg-perl libfakeroot libfile-fcntllock-perl \
    libgcc-4.8-dev libglib2.0-0 libglib2.0-data libgmp10 libgomp1 libisl10 \
    libitm1 libmpc3 libmpfr4 libperl-dev libperl5.18 libquadmath0 libssl-dev \
    libssl-doc libstdc++-4.8-dev libtimedate-perl libtsan0 libxml2 \
    linux-libc-dev make manpages manpages-dev patch pkg-config sgml-base \
    shared-mime-info xml-core xz-utils zlib1g-dev
apt-get clean

rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*
