#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "qt" --supported "macos-arm64 macos-x86_64" "$@"

QT_VERSION="6.8.1"

export CXXFLAGS="-DQT_MESSAGELOGCONTEXT"
export OBJCXXFLAGS="$CXXFLAGS"

tar Jxf <(curl -L "https://download.qt.io/archive/qt/$(echo "$QT_VERSION" | grep -o '...')/$QT_VERSION/submodules/qtbase-everywhere-src-$QT_VERSION.tar.xz")
cd "qtbase-everywhere-src-$QT_VERSION"
rm -rf _build && mkdir _build && cd _build
../configure \
  --prefix="$DEP_PREFIX/qt" \
  -appstore-compliant \
  -static \
  -release \
  -force-asserts \
  -qt-doubleconversion \
  -qt-freetype \
  -qt-harfbuzz \
  -qt-libjpeg \
  -qt-libpng \
  -qt-pcre \
  -qt-zlib \
  -no-feature-androiddeployqt \
  -no-feature-brotli \
  -no-feature-macdeployqt \
  -no-feature-printsupport \
  -no-feature-qmake \
  -no-feature-sql \
  -no-feature-dbus \
  -no-opengl \
  -no-openssl \
  -- \
  -DCMAKE_FIND_ROOT_PATH="$DEP_PREFIX" \
  -Wno-dev
cat config.summary
cmake --build .
cmake --install .
cd ../..
rm -rf "qtbase-everywhere-src-$QT_VERSION"

tar Jxf <(curl -L "https://download.qt.io/archive/qt/$(echo "$QT_VERSION" | grep -o '...')/$QT_VERSION/submodules/qttools-everywhere-src-$QT_VERSION.tar.xz")
cd "qttools-everywhere-src-$QT_VERSION"
rm -rf _build && mkdir _build && cd _build
"$DEP_PREFIX/qt/bin/qt-configure-module" .. \
  -no-feature-assistant \
  -no-feature-designer \
  -no-feature-kmap2qmap \
  -no-feature-pixeltool \
  -no-feature-qdbus \
  -no-feature-qdoc \
  -no-feature-qev \
  -no-feature-qtattributionsscanner \
  -no-feature-qtdiag \
  -no-feature-qtplugininfo \
  -- \
  -DCMAKE_FIND_ROOT_PATH="$DEP_PREFIX" \
  -Wno-dev
cmake --build .
cmake --install .
cd ../..
rm -rf "qttools-everywhere-src-$QT_VERSION"

tar Jxf <(curl -L "https://download.qt.io/archive/qt/$(echo "$QT_VERSION" | grep -o '...')/$QT_VERSION/submodules/qtsvg-everywhere-src-$QT_VERSION.tar.xz")
cd "qtsvg-everywhere-src-$QT_VERSION"
rm -rf _build && mkdir _build && cd _build
"$DEP_PREFIX/qt/bin/qt-configure-module" .. \
  -- \
  -DCMAKE_FIND_ROOT_PATH="$DEP_PREFIX" \
  -Wno-dev
cmake --build .
cmake --install .
cd ../..
rm -rf "qtsvg-everywhere-src-$QT_VERSION"
