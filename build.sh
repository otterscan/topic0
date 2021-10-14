#!/bin/bash
set -e
rm -fr signatures && mkdir signatures
rm -fr with_parameter_names && mkdir with_parameter_names
find ./sourcify-snapshot/repo/contracts/full_match/1 -name "metadata.json" -print0 | parallel -0 ./process-file.sh {} \;
find ./with_parameter_names -type f -print0 | parallel -0 sort {} "|" uniq -c "|" sort -nr "|" sort -u -t '!' -k2,2 "|" sort -nr "|" sed "'s/^ *[0-9]\{1,\} //'" "|" sed "'s/\!.*$//'" "|" tr "\"\n\"" "';'" "|" sed "'s/.$//'" "|" sponge {} \;
