#!/bin/bash -xe
# SPDX-License-Identifier: GPL-2.0-or-later

additional_opts=$1

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SRC_DIR=$SCRIPT_DIR/../src
BUILD_DIR=$SCRIPT_DIR/../builddir

ALL_SRC_FILES=$(find $SRC_DIR -name "*.[ch]" \
        ! -path "$SRC_DIR/libhirte/ini/ini.[ch]" \
        ! -path "$SRC_DIR/libhirte/hashmap/hashmap.[ch]" \
        ! -path "$SRC_DIR/*/test/**" \
        ! -path "$BUILD_DIR/**")

for src_file in $ALL_SRC_FILES
do
    echo "Linting $src_file..."

    # Header config.h is autogenerated during the build, so it needs to be added manually here as a parameter
    clang-tidy $additional_opts --quiet $src_file -- -I $SRC_DIR -I $BUILD_DIR -include config.h
done