pragma solidity >=0.6.0;

import "ds-auth/auth.sol";

import "./base.sol";

contract DSDeed is DSDeedBase, DSAuth {

    bool   public   stopped;

    modifier stoppable {
        require(!stopped, "ds-stop-is-stopped");
        _;
    }

    constructor(string memory name, string memory symbol) DSDeedBase(name, symbol) public {}

    event Mint(address indexed guy, uint256 nft);
    event Burn(address indexed guy, uint256 nft);
    event Stop();
    event Start();

    uint256 private _ids;

    function push(address dst, uint256 nft) external {
        transferFrom(msg.sender, dst, nft);
    }

    function pull(address src, uint256 nft) external {
        transferFrom(src, msg.sender, nft);
    }

    function move(address src, address dst, uint256 nft) external {
        transferFrom(src, dst, nft);
    }

    function mint(string memory uri) public returns (uint256) {
        return mint(msg.sender, uri);
    }

    function mint(address guy) public returns (uint256) {
        return mint(guy, "");
    }

    function mint(address guy, string memory uri) public auth stoppable returns (uint256 nft) {
        require(guy != address(0), "ds-deed-invalid-address");
        nft = _ids++;
        _allDeeds.push(nft);
        _deeds[nft] = Deed(
            _allDeeds[_allDeeds.length - 1],
            _usrDeeds[guy].length - 1,
            guy,
            address(0)
        );
        _upush(guy, nft);
        _uris[nft] = uri;
        emit Mint(guy, nft);
    }

    function burn(uint256 nft) public auth stoppable {
        address guy = _deeds[nft].guy;
        require(guy != address(0), "ds-deed-invalid-nft");

        uint256 _idx       = _deeds[nft].pos;
        uint256 _mov       = _allDeeds[_allDeeds.length - 1];
        _allDeeds[_idx]    = _mov;
        _deeds[_mov].pos    = _idx;
        _allDeeds.pop();    // Remove from All deed array
        _upop(nft);         // Remove from User deed array

        delete _deeds[nft]; // Remove from deed mapping

        emit Burn(guy, nft);
    }

    function stop() public auth {
        stopped = true;
        emit Stop();
    }

    function start() public auth {
        stopped = false;
        emit Start();
    }

    function setTokenUri(uint256 nft, string memory uri) public auth stoppable {
        _uris[nft] = uri;
    }
}
