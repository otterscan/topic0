#!/bin/bash
set -e
rm -fr signatures && mkdir signatures
rm -fr with_parameter_names && mkdir with_parameter_names
find ./sourcify-snapshot/repo/contracts/full_match/1 -name "metadata.json" -print0 | parallel -0 ./process-file.sh {} \;
find ./with_parameter_names -type f -print0 | parallel -0 sort {} "|" uniq -c "|" sort -nr "|" head -n 1 "|" sed "'s/^ *[0-9]\{1,\} //'" "|" sponge {} \;
