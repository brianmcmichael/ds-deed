pragma solidity >0.4.20;

import "ds-stop/stop.sol";

import "./base.sol";

contract DSDeed is DSDeedBase, DSStop {

    constructor(string memory name, string memory symbol) DSDeedBase(name, symbol) public {}

    event Mint(address indexed guy, uint256 nft);
    event Burn(address indexed guy, uint256 nft);

    uint256 private _ids;

    function mint(string memory uri) public {
        mint(msg.sender, uri);
    }

    function mint(address guy) public {
        mint(guy, "");
    }

    function mint(address guy, string memory uri) public auth stoppable returns (uint256 nft) {
        nft = _ids++;
        _allDeeds.push(nft);
        _upush(guy, nft);
        _deeds[_ids] = Deed(
            _allDeeds[_allDeeds.length - 1],
            _usrDeeds[guy].length - 1,
            guy,
            address(0)
        );
        setTokenUri(nft, uri);
        emit Mint(guy, _ids);
    }

    function burn(uint256 nft) public auth stoppable {
        address guy = _deeds[nft].guy;
        _upop(nft);
        uint256 _idx = _deeds[nft].pos;
        uint256 _mov = _allDeeds[_allDeeds.length - 1];
        _allDeeds[_idx] = _mov;
        _deeds[nft].pos = _idx;
        _allDeeds.pop();
        emit Burn(guy, nft);
    }

    function setTokenUri(uint256 nft, string memory uri) public auth stoppable {
        _uris[nft] = uri;
    }
}
