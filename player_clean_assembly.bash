#!/bin/bash

# produce bin file from decimal byte listing
cd /mnt/opti2/c/zeus/
cp player0889.c ~/
gcc ~/player0889.c -o ~/player0889.o
~/player0889.o

# use emulator to load bin file created above into memory and disassemble it
# load player0889_src.bin at $FA00 and
# player0889_music.bin at $EA60
# place disassembled code in player0889.asm
sed -n -e '/^[0-9A-F]/{s/\([0-9A-F]\{4\}\)\([^a-z]*\)\([a-z].*\)/\1\t\3/;p};/^[^0-9A-F]/p' player0889.asm > player0889_clean.asm

# extract labels used in jmp etc.
cat player0889_clean.asm | rev | sed -n -e '/^.[0-9A-F]\{4\}/{s/\(^.[0-9A-F]\{4\}\)\(.*\)/\1/;p}' | rev | sort | uniq > player0889_labels.txt

#remove labels that are not referenced in code from assembly
while read line; do
  mylabel=$( echo ${line:0:4} | grep '^[0-9A-F]\{4\}' )
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

# add dollar signs to db lines file
sed -i -e 's/[0-9A-F]\{2\}/$&/g;s/$DB/DB/;/^\tDB\t\$/s/ \$/,$/g' dblines.txt

# add dollar signs to lines in assembly that use hex numbers, not labels
sed -e 's/\(\tld\t.*,\)\([0-9A-F]\{2,4\}\)/\1$\2/;s/\(\tcp\t\)\([0-9A-F]\{2,4\}\)/\1$\2/;s/\(\tand\t\)\([0-9A-F]\{2,4\}\)/\1$\2/;s/\(\txor\t\)\([0-9A-F]\{2,4\}\)/\1$\2/;' player0889_labels.asm > player0889_labels2.asm

