#!/usr/bin/env bash

set -e

SRCPATH="$( cd "$(dirname "$0")" ; pwd -P )"
NPROC=$(nproc || grep -c ^processor /proc/cpuinfo)

build_dir="$SRCPATH/build_"
mkdir -p $build_dir && cd $build_dir
cmake "$SRCPATH" \
    -DENABLE_TESTS=on -DENGINE_RADIX=ON
make -j 2
