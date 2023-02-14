#/usr/bin/env bash
set -e

sources_directory=$1

# modifiied from https://stackoverflow.com/questions/12551249/using-sed-to-remove-bodies-of-functions-on-a-c-c-file
remove_to_string() {
    filename=$1
    sed -i '/std::string to_string() const {$/ {:r;/\n}/!{N;br}; s/std::string to_string() const {\n.*\n/\n/}' $filename
}

remove_to_string $sources_directory/include/ruckig/block.hpp
remove_to_string $sources_directory/include/ruckig/output_parameter.hpp
remove_to_string $sources_directory/include/ruckig/profile.hpp
remove_to_string $sources_directory/include/ruckig/input_parameter.hpp
