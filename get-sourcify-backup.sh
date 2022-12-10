#!/bin/bash
set -e

SOURCIFY_IPNS_ROOT="repo.sourcify.dev"

echo "Removing previous snapshot..."
rm -fr sourcify-snapshot && mkdir -p sourcify-snapshot

# note to future maintainers: ipfs get -a (get tar+unpack dir) is faster than non -a ipfs get
echo "Getting Sourcify repo from ipfs..."
ipfs get "/ipns/$SOURCIFY_IPNS_ROOT" -o sourcify-snapshot.tar -a
tar xf sourcify-snapshot.tar -C sourcify-snapshot
mv "sourcify-snapshot/$SOURCIFY_IPNS_ROOT" sourcify-snapshot/repo
