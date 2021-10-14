#!/bin/bash
SIG=$1
SIG_COMPLETE=$2
SIG_WITHOUT_NAMES=$3
TOPIC0=`echo $SIG | tr -d "\n" | keccak-256sum | cut -d " " -f1`

if [ ! -f signatures/$TOPIC0 ]; then
  echo $SIG > signatures/$TOPIC0
fi

echo "$SIG_COMPLETE!$SIG_WITHOUT_NAMES" >> with_parameter_names/$TOPIC0
