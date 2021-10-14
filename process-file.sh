#!/bin/bash
METADATA_FILE="${1:-$(</dev/stdin)}"

JQ_FILTER='.output.abi[] | select ((.anonymous | not) and .type == "event") | .name+"("+(.inputs | map(.type) | join(","))+")",.name+"("+(.inputs | map(.type+(if .indexed then " indexed" else "" end)+" "+.name) | join(","))+")",.name+"("+(.inputs | map(.type+(if .indexed then " indexed" else "" end)) | join(","))+")"'
cat $METADATA_FILE | jq "$JQ_FILTER" -r | tr \\n \\0 | xargs -0 -L3 ./process-sig.sh
