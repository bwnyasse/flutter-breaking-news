#!/usr/bin/env bash
#
# Script used to add licence header into dart files
#

set -e

CURRENT_DIR=$(pwd)

[[ ! -f "$CURRENT_DIR/pubspec.yaml" ]] && echo 'the script must be run into flutter root directory' && exit 1

for i in $(find lib/ test/ -name '*.dart') # or whatever other pattern...
do
  if ! grep -q Copyright $i
  then
    cat license.txt $i >$i.new && mv $i.new $i
  fi
done