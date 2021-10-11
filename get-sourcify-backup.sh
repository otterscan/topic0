#!/bin/bash
set -e

SOURCIFY_BACKUP_HASH="QmWV29hqZfEhJSmT9FNPreS1d4bh2iaGpfN2Wz6EbHL1U9"

ipfs get $SOURCIFY_BACKUP_HASH -o sourcify-backup.tar.bz2
mkdir -p sourcify-snapshot
tar xf sourcify-backup.tar.bz2 -C sourcify-snapshot
