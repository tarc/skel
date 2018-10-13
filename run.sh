#!/bin/bash

script_dir=$(dirname "$0")

if [ $# -eq 0 ]; then
  build_type="Debug"
else
  build_type=$1
fi

./$script_dir/build.sh $build_type || exit 1

run_dir=$script_dir/$build_type/bin

cd $run_dir

./skel
