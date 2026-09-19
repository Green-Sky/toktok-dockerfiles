#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2026 The TokTok team

set -euo pipefail

TOXCORE_VERSION=0.2.23
TOXCORE_HASH=15cdd006ed7793dfc657e340ef9f218f6637d2fe5b130704d39b961389bb6cd6

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  https://github.com/TokTok/c-toxcore/releases/download/v"$TOXCORE_VERSION/c-toxcore-v$TOXCORE_VERSION".tar.gz \
  "$TOXCORE_HASH"
