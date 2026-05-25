#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2026 The TokTok team

set -euo pipefail

TOXCORE_VERSION=0.2.23-rc.2
TOXCORE_HASH=124447d873ce6dd232ac3a501e06cb42d5c5c2d4f6c705a00c91991acc46e9ad

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  https://github.com/TokTok/c-toxcore/releases/download/v"$TOXCORE_VERSION/c-toxcore-v$TOXCORE_VERSION".tar.gz \
  "$TOXCORE_HASH"
