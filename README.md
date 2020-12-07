# Under Construction

# DSDeed

_An ERC721 Token with wholesome memes_

Provides a standard [ERC721](http://erc721.org/) token interface plus [DSAuth](https://dapp.tools/dappsys/ds-auth)-protected
`mint` and `burn` functions.


### Custom Actions

#### `mint`
credit NFT at an address whilst simultaniously increasing user's `balanceOf`
(requires auth)

#### `burn`
debit NFT at an address whilst simultaniously decreasing user's `balanceOf`
(requires auth)
