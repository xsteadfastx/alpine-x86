#!/usr/bin/env bash

MIRROR=http://nl.alpinelinux.org/alpine
TOOLS_VERSION="2.6.7-r0"
ROOTFS="/tmp/rootfs"
VERSION=$1

# TOOLS
mkdir /root/apk-tools-static
cd /root/apk-tools-static
wget "$MIRROR/latest-stable/main/x86/apk-tools-static-$TOOLS_VERSION.apk"
tar -xzf apk-tools-static-$TOOLS_VERSION.apk

# CREATE CHROOT
./sbin/apk.static -X $MIRROR/$VERSION/main -U --allow-untrusted --root $ROOTFS --initdb add alpine-base
rm -f "$ROOTFS/var/cache/apk"/*

# REPOS
mkdir -p "$ROOTFS/etc/apk"
echo "$MIRROR/$VERSION/main" > "$ROOTFS/etc/apk/repositories"
echo "$MIRROR/$VERSION/community" >> "$ROOTFS/etc/apk/repositories"

tar -z -f rootfs.tar.gz --numeric-owner -C "$ROOTFS" -c .
mv rootfs.tar.gz /data
chown $USERID /data/rootfs.tar.gz
