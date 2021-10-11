#!/bin/bash
METADATA_FILE="${1:-$(</dev/stdin)}"
cat $METADATA_FILE | jq '.output.abi[] | select ((.anonymous | not) and .type == "event") | .name+"("+(.inputs | map(.type) | join(","))+")",.name+"("+(.inputs | map(.type+(if .indexed then " indexed" else "" end)+" "+.name) | join(","))+")"' -r | tr \\n \\0 | xargs -0 -L2 ./process-sig.sh
