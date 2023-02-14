#/usr/bin/env bash
set -e

sources_directory=$1

fix_trajectory_weirdness() {
    filename=$1

    # Fixes "error: use of 'this' in a constant expression" compile error, which
    # is likely an old compiler bug? Especially if just switching their order
    # fixes this weirdness
    weirdness='s/section_position_extrema\.min < position_extrema\[dof\]\.min/\position_extrema\[dof\]\.min \> section_position_extrema\.min/g'
    perl -i -pe "$weirdness" "$sources_directory/include/ruckig/trajectory.hpp"
}

fix_trajectory_weirdness
