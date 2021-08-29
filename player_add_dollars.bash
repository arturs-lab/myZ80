#!/bin/bash

sed -e 's/\(\tld\t.*,\)\([0-9A-F]\{2,4\}\)/\1$\2/;s/\(\tcp\t\)\([0-9A-F]\{2,4\}\)/\1$\2/;s/\(\tand\t\)\([0-9A-F]\{2,4\}\)/\1$\2/;s/\(\txor\t\)\([0-9A-F]\{2,4\}\)/\1$\2/;' player0889_labels.asm > player0889_labels2.asm

