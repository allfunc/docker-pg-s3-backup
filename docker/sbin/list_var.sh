#!/usr/bin/env sh
DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)"

find $DIR -name "ver_*.sh" -exec basename -s ".sh" {} \; | sed 's/ver_//g' | sort 
