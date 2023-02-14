#!/usr/bin/env bash
set -e

sources_directory=$1

disable_if='s/if \(.*(throw_error|DOFs == 0).*\)/if \(false\)/g'
comment_throw_exception='s/throw std/\/\/throw std/g'

perl -i -pe "$disable_if;$comment_throw_exception" $sources_directory/include/ruckig/*.hpp
