# Rebuilding the repo

This repo comes with a set of already extracted data, so if you just want to consume the data, no further action is needed.

However, everything here is verifiable and reproducible, so if you want to rebuild it yourself, follow the instructions bellow.

## Requirements

- Standard unix tools
- ipfs
- GNU parallel
- jq (https://stedolan.github.io/jq/)
- sponge; provided by [moreutils](https://joeyh.name/code/moreutils/)
- keccak-256sum; provided by [sha3sum package](https://github.com/maandree/sha3sum)

## Get a Sourcify backup

Run:

```
./get-sourcify-backup.sh
```

### Wait, where does this backup come from?

It downloads the content `/ipns/k51qzi5uqu5dll0ocge71eudqnrgnogmbr37gsgl12uubsinphjoknl6bbi41p` from IPFS. This is the public Sourcify repository production root hash.

## Rebuild the signature database

```
./build.sh
```
