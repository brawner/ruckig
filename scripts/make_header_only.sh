#/usr/bin/env bash
set -e

sources_directory=$1

inline_functions() {
    filename=$1
    inline_void="s/(?<!inline )void (?=[\w:]+\()/inline void /g"
    inline_bool="s/(?<!inline )bool (?=[\w:]+\()/inline bool /g"
    inline_explicit="s/(?<!inline )explicit (?=[\w:]+\()/inline explicit /g"
    perl -i -pe "$inline_void;$inline_bool;$inline_explicit" $filename
}

make_header_only(){
    src_file=$1
    destination_header=$2
    destination_path=$sources_directory/include/ruckig/$destination_header
    header_file=$sources_directory/include/ruckig/$3

    mv "$sources_directory/src/ruckig/$src_file" $destination_path
    sed -i "1i #pragma once" $destination_path

    include_to_add="#include <ruckig/$destination_header>"
    if ! grep -q "$include_to_add" $header_file
    then
        echo $include_to_add >> $header_file
    fi

    inline_functions $header_file
    inline_functions $destination_path
}

make_header_only brake.cpp brake_impl.hpp brake.hpp
make_header_only position-step1.cpp position-step1.hpp position.hpp
make_header_only position-step2.cpp position-step2.hpp position.hpp
make_header_only velocity-step1.cpp velocity-step1.hpp velocity.hpp
make_header_only velocity-step2.cpp velocity-step2.hpp velocity.hpp
