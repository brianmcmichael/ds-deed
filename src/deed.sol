pragma solidity >0.4.20;

import "ds-stop/stop.sol";

import "./base.sol";

contract DSDeed is DSDeedBase, DSStop {

    constructor(string memory name, string memory symbol) DSDeedBase(name, symbol) public {}

    event Mint(address indexed guy, uint256 nft);
    event Burn(address indexed guy, uint256 nft);

    uint256 private _ids;

    function mint(address guy) public auth stoppable returns (uint256 nft) {
        nft = _ids++;
        _allDeeds.push(nft);
        _upush(guy, nft);
        _deeds[_ids] = Deed(
            _allDeeds[_allDeeds.length - 1],
            _usrDeeds[guy].length - 1,
            guy,
            address(0)
        );
        emit Mint(guy, _ids);
    }

    function burn(address guy, uint256 nft) public auth stoppable {
        // TODO

        emit Burn(guy, nft);
    }
}
