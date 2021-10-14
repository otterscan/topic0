# Gotchas

Some decisions have been made in order to reduce the noise of generated data.

Those heuristic decisions seem to just work fine for most cases, i.e., hashes are resolved to event signatures with good parameter names and correct `indexed` settings. Feel free to open issues and suggest improvements for edge cases.

## Eliminate junk signatures

The build script processes only the Ethereum mainnet directory of Sourcify repository.

Other chains and testnets are ignored.

## Parameter names are decided by popularity

Let's take the ubiquitous `ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef` hash, which corresponds to the `Transfer(address indexed from, address indexed to, uint256 value)` ERC20 event signature.

It may also represent:

- `Transfer(address indexed _from, address indexed _to, uint256 _value)`
- `Transfer(address indexed banana, address indexed coconut, uint256 pineapple)`
- `Transfer(address indexed aaaaaaa, address indexed bbbbbbb, uint256 ccccccc)`

Can you see? Parameter names are erased from the signature before calculating the hash. The actual string used to calculate the keccak256 is `Transfer(address,address,uint256)`.

We are taking a pragmatic approach for now, so we assume:

- People copy/paste popular code/libraries, so we consider most used parameter name combinations are a _de facto_ consensus.
- Scrapping only mainnet verified contracts eliminate junk code, people have to pay actual money to deploy their contracts, so there is some curation here, reinforcing the first point.

What does it mean for this repository purposes? In technical terms, our scripts count all individual signature occurrences for each hash and take the one who appears the most _per signature variation_ (in a high level: `sort | uniq -c | sort -nr | sort -u -t -k<variation field> | sort -nr`).

## `indexed` vs non-`indexed` signature collisions

This one is quite problematic. Let's examine again the ubiquitous `ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef` signature. It corresponds to ERC20 `Transfer(address indexed from, address indexed to, uint256 value)`.

**However** it also corresponds to the nowadays popular ERC721 `Transfer(address indexed from, address indexed to, uint256 indexed tokenId)` NFT transfer event. The issue is that the `indexed` parameter attribute also gets erased from the event signature before applying the keccak256.

It is not possible to guess which signature is the "correct" by just looking at the hash. The consequences are catastrophic, because the `indexed` attribute determines where you should look at when decoding the value.

For ERC20 tokens, the non-indexed value should be decoded from event data, while ERC721 tokens have the token ID stored in an extra topic.

There is no way to solve this 100%, so we recommend consumers of this database to guard themselves against errors while decoding, and if an error occur, try to decode the log using other signature variations if there are more than one. The build script guarantees that variations are sorted by popularity descending.
