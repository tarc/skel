#!/bin/bash

command -v conan >/dev/null 2>&1 || { echo >&2 "Missing conan command"; exit 1; }

command -v cmake >/dev/null 2>&1 || { echo >&2 "Missing cmake command"; exit 1; }

script_dir=$(dirname "$0")

if [ $# -eq 0 ]; then
  build_type="Debug"
else
  build_type=$1
fi

gen_dir=$script_dir/$build_type

if [ -e $gen_dir ]; then
  rm -rf $gen_dir
fi

mkdir $gen_dir

pushd $gen_dir

conan install .. -s build_type=$build_type -s arch=x86_64 || exit 1;

cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=$build_type \
  || exit 1

popd >/dev/null 2>&1

if [ ! -e ./compile_commands.json ]; then
  ln -s $build_type/compile_commands.json ./
fi
