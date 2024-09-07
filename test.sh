#!/usr/bin/env bash

STORAGE_PATH="/mirror-data/void"

rsync \
  --recursive \
  --links \
  --perms \
  --times \
  --compress \
  --progress \
  --delete \
  --exclude='debug' \
  --exclude='aarch64' \
  --exclude='*.armv7l.xbps' \
  --exclude='armv6l.xbps' \
  --exclude='*.i686.xbps' \
  --exclude='*.armv?l.convolution' \
  --exclude='musl' \
  --exclude 'multilib' \
  --exclude 'nonfree' \
  --dry-run \
  --stats \
  rsync://mirrors.servercentral.com/voidlinux \
 $STORAGE_PATH
