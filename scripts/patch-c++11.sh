# If there is no argument, create subdirectory for patch and copy all relevant files
set -e

output_directory=$1
optional_include=$2

mkdir -p $output_directory
cp -r include src examples cmake test third_party CMakeLists.txt $output_directory/

# Download optional polyfill
mkdir -p $output_directory/include/nonstd/
wget -O $output_directory/include/nonstd/optional.hpp https://raw.githubusercontent.com/martinmoene/optional-lite/master/include/nonstd/optional.hpp

# Replace function, be careful with overwriting a file
replace () {
    sed -i "${@:2}" "$1"
}

# Replace optional, if constexpr, and C++ version
replace $output_directory/include/ruckig/block.hpp -e "s|<optional>|<${optional_include}>|g" -e "s|if constexpr|if|g"
replace $output_directory/include/ruckig/calculator_target.hpp -e "s|<optional>|<${optional_include}>|g" -e "s|if constexpr|if|g"
replace $output_directory/include/ruckig/input_parameter.hpp -e "s|<optional>|<${optional_include}>|g"
replace $output_directory/include/ruckig/position.hpp -e "s|<optional>|<${optional_include}>|g"
replace $output_directory/include/ruckig/profile.hpp -e "s|<optional>|<${optional_include}>|g" -e "s|if constexpr|if|g"
replace $output_directory/include/ruckig/roots.hpp -e "s|if constexpr|if|g"
replace $output_directory/include/ruckig/ruckig.hpp -e "s|<optional>|<${optional_include}>|g" -e "s|if constexpr|if|g"
replace $output_directory/include/ruckig/trajectory.hpp -e "s|if constexpr|if|g"
replace $output_directory/include/ruckig/velocity.hpp -e "s|<optional>|<${optional_include}>|g"
replace $output_directory/test/test-target.cpp -e "s|<optional>|<${optional_include}>|g"
replace $output_directory/test/test-target-known.cpp -e "s|<optional>|<${optional_include}>|g"

replace $output_directory/CMakeLists.txt -e "s|cxx_std_17|cxx_std_11|g" -e "s|if(BUILD_BENCHMARK)|if(FALSE)|g"
