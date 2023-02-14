#/usr/bin/env bash
set -e
sources_directory=$1

remove_string="s/#include <string>//g"
remove_iostream="s/#include <iostream>//g"
remove_iomanix="s/#include <iomanip>//g"
remove_sstream="s/#include <sstream>//g"

perl -i -pe "$remove_string;$remove_iostream;$remove_iomanix;$remove_sstream" $sources_directory/include/ruckig/*.hpp
