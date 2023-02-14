#/usr/bin/env bash
set -e
sources_directory=$1

set_literals_to_doubles() {
    filename=$1
    replace_first_0='s/\(0.0,/\(double\(0.0\),/g'
    replace_second_0='s/, 0.0\)/, double\(0.0\)\)/g'
    replace_1='s/, 1.0\)/, double\(1.0\)\)/g'
    replace_minus_1='s/, -1.0\)/, double\(-1.0\)\)/g'
    perl -i -pe "$replace_first_0;$replace_second_0;$replace_1;$replace_minus_1" $filename
}

set_literals_to_doubles $sources_directory/include/ruckig/brake_impl.hpp
set_literals_to_doubles $sources_directory/include/ruckig/roots.hpp
set_literals_to_doubles $sources_directory/include/ruckig/trajectory.hpp
set_literals_to_doubles $sources_directory/include/ruckig/position-step1.hpp
set_literals_to_doubles $sources_directory/include/ruckig/position-step2.hpp
