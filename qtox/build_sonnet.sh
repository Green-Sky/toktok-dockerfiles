#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "sonnet" --supported "macos-x86_64 macos-arm64" "$@"

"$SCRIPT_DIR/download/download_sonnet.sh"

find . -name CMakeLists.txt -exec sed -i '' -e 's/ MODULE$/ STATIC/g' '{}' ';'
find . -name CMakeLists.txt -exec sed -i '' -e 's/install(TARGETS sonnet_\([^ ]*\) /&EXPORT KF6SonnetTargets/g' '{}' ';'
find . -name CMakeLists.txt -exec sed -i '' -e 's/target_link_libraries(KF6SonnetCore PUBLIC Qt6::Core)/target_link_libraries(KF6SonnetCore PUBLIC Qt6::Core sonnet_hunspell sonnet_nsspellchecker)/' '{}' ';'

export PATH="$DEP_PREFIX/qt/bin:$PATH"
"$DEP_PREFIX/qt/bin/qt-cmake" \
  -DCMAKE_INSTALL_PREFIX="$DEP_PREFIX" \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=OFF \
  -DSONNET_USE_QML=OFF \
  -DCMAKE_CXX_FLAGS="-DSONNET_STATIC -DQT_MESSAGELOGCONTEXT" \
  -B_build \
  -GNinja \
  .
cmake --build _build
cmake --install _build
mv "$DEP_PREFIX/include/KF6/SonnetUi/Sonnet" "$DEP_PREFIX/include/KF6/SonnetUi/sonnet"
