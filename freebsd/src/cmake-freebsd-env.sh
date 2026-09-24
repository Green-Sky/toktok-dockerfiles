#!/bin/bash
# Copyright © 2018-2023 nurupo
# Copyright © 2026 The TokTok team

# Common variables and functions

NPROC="$(nproc)"

SCREEN_SESSION=freebsd
SSH_PORT=10022

FREEBSD_VERSION="14.5"
IMAGE_NAME="FreeBSD-$FREEBSD_VERSION-RELEASE-amd64.qcow2"
# https://download.freebsd.org/ftp/releases/VM-IMAGES/14.5-RELEASE/amd64/Latest/
IMAGE_SHA512="9960eea5f5dfbd7e95de023dbf3cc5771dabe1dd633a98f2069ac99b3de8d444455df313fc15da5de8d149cfb5d65eee25526d7fb30bb04f75b8c65a85e59bf6"
