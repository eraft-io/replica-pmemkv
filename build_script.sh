#!/usr/bin/env bash

set -e

SRCPATH="$( cd "$(dirname "$0")" ; pwd -P )"
NPROC=$(nproc || grep -c ^processor /proc/cpuinfo)

if [ -d "$SRCPATH/protocol" ]; then
  cd "$SRCPATH/protocol"
  chmod -R 755 scripts
  ./scripts/generate_cpp.sh
  cd -
fi

build_dir="$SRCPATH/build_"
mkdir -p $build_dir && cd $build_dir
cmake "$SRCPATH" \
    -DENABLE_TESTS=on -DENGINE_RADIX=ON -DENGINE_CSMAP=ON
make -j 1
