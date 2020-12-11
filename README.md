
# DSDeed

_An ERC721 Token with wholesome memes_

Provides a standard [ERC721](https://eips.ethereum.org/EIPS/eip-721) token interface plus [DSAuth](https://dapp.tools/dappsys/ds-auth)-protected `mint` and `burn` functions.

Inspired by dapphub's [ds-token](https://github.com/dapphub/ds-token)

### Custom Actions

#### `mint`
credit NFT at an address whilst simultaniously increasing user's `balanceOf`
(requires auth)

#### `burn`
debit NFT at an address whilst simultaniously decreasing user's `balanceOf`
(requires auth)

### Aliases

#### `push`
safe transfer a nft from `msg.sender` to a given address (requires approval)

#### `pull`
safe transfer a nft from a given address to `msg.sender` (requires approval)

#### `move`
safe transfer a nft from a given `src` address to a given `dst` address (requires approval)
