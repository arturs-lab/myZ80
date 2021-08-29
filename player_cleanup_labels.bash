#!/bin/bash

while read line; do
  mylabel=${line:0:4}
  if [ "x${mylabel}" == "x" ]; then
    echo ${line}
    continue
  fi
#  echo ${line}
  if [ "x$( grep ${mylabel} player0889_labels.txt )" != "x" ]; then
    echo ${line}
  else
    echo ${line} | sed -e 's/^[0-9A-F]\{4\}//'
  fi
done < player0889_clean.asm
