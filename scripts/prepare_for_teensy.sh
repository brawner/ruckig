#/usr/bin/env bash
set -ex

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"


$SCRIPT_DIR/patch-c++11.sh $SCRIPT_DIR/../patch-cpp11 stdlib/optional.hpp
$SCRIPT_DIR/make_header_only.sh patch-cpp11
$SCRIPT_DIR/set_literals_to_doubles.sh patch-cpp11
$SCRIPT_DIR/remove_to_string.sh patch-cpp11
$SCRIPT_DIR/disable_exceptions.sh patch-cpp11
$SCRIPT_DIR/fixes_for_weirdness.sh patch-cpp11
$SCRIPT_DIR/remove_heavy_headers.sh patch-cpp11

# Minimize diffs
clang-format-12 -i patch-cpp11/include/ruckig/*.hpp
