pragma solidity >0.4.20;

import "ds-stop/stop.sol";

import "./base.sol";

contract DSDeed is DSDeedBase, DSStop {

    constructor(string memory name, string memory symbol) DSDeedBase(name, symbol) public {}

    event Mint(address indexed guy, uint256 nft);
    event Burn(address indexed guy, uint256 nft);

    function mint() public {
        // TODO
    }

    function burn() public {
        // TODO
    }
}
