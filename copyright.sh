#!/bin/bash

for i in $(find lib/ test/ -name '*.dart') # or whatever other pattern...
do
  if ! grep -q Copyright $i
  then
    cat copyright-header.txt $i >$i.new && mv $i.new $i
  fi
done