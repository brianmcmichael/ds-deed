/// base.sol -- basic ERC721 implementation

// Copyright (C) 2020  Brian McMichael

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity >=0.4.23;

import "erc721/erc721.sol";

contract DSDeedBase is ERC721, ERC721Enumerable, ERC721Metadata {

    string                                         private _name;
    string                                         private _symbol;

    mapping (uint256 => string)                    private _uris;

    mapping (bytes4 => bool)                       private _interfaces;

    uint256[]                                      private _allDeeds;
    mapping (address => uint256[])                 private _usrDeeds;
    mapping (uint256 => Deed)                      private _deeds;
    mapping (address => mapping (address => bool)) private _operators;

    struct Deed {
        uint256      pos;
        uint256     upos;
        address      guy;
        address approved;
    }

    constructor(string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;
        _addInterface(0x80ac58cd); // ERC721
        _addInterface(0x5b5e139f); // ERC721Metadata
        _addInterface(0x780e9d63); // ERC721Enumerable
    }

    modifier mine(uint256 nft) {
        require(
            _deeds[nft].guy == msg.sender ||
            _deeds[nft].approved == msg.sender ||
            _operators[_deeds[nft].guy][msg.sender],
            "ds-deed-insufficient-approval"
        );
        _;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function tokenURI(uint256 nft) external view returns (string memory) {
        return _uris[nft];
    }

    function totalSupply() public view returns (uint256) {
        return _allDeeds.length;
    }

    function tokenByIndex(uint256 idx) public view returns (uint256) {
        return _allDeeds[idx];
    }

    function tokenOfOwnerByIndex(address guy, uint256 idx) public view returns (uint256) {
        return _usrDeeds[guy][idx];
    }

    function onERC721Received(address, address, uint256, bytes calldata) external returns(bytes4) {
        return this.onERC721Received.selector;
    }

    function _isContract(address addr) private view returns (bool) {
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470; // EIP-1052
        assembly { codehash := extcodehash(addr) }
        return (codehash != accountHash && codehash != 0x0);
    }

    function supportsInterface(bytes4 interfaceID) external view returns (bool) {
        return _interfaces[interfaceID];
    }

    function _addInterface(bytes4 interfaceID) private {
        _interfaces[interfaceID] = true;
    }

    function balanceOf(address guy) public view returns (uint256) {
        require(guy != address(0), "ds-deed-invalid-address");
        return _usrDeeds[guy].length;
    }

    function ownerOf(uint256 nft) public view returns (address) {
        require(_deeds[nft].guy != address(0), "ds-deed-invalid-nft");
        return _deeds[nft].guy;
    }

    function safeTransferFrom(address src, address dst, uint256 nft, bytes memory what) public payable {
        _safeTransfer(src, dst, nft, what);
    }

    function safeTransferFrom(address src, address dst, uint256 nft) public payable {
        _safeTransfer(src, dst, nft, "");
    }

    function _safeTransfer(address src, address dst, uint256 nft, bytes memory data) internal {
        transferFrom(src, dst, nft);
        if (_isContract(dst)) {
            bytes4 res = ERC721TokenReceiver(dst).onERC721Received(msg.sender, src, nft, data);
            require(res == this.onERC721Received.selector, "ds-deed-invalid-token-receiver");
        }
    }

    function transferFrom(address src, address dst, uint256 nft) public payable mine(nft) {
        require(src == _deeds[nft].guy, "ds-deed-src-not-valid");
        require(dst != address(0), "ds-deed-unsafe-destination");
        require(_deeds[nft].guy != address(0), "ds-deed-invalid-nft");
        _upop(nft);
        _upush(dst, nft);
        approve(address(0), nft);
        emit Transfer(src, dst, nft);
    }

    function _upop(uint256 nft) internal {
        uint256[] storage _udds = _usrDeeds[_deeds[nft].guy];
        uint256   _uidx = _deeds[nft].upos;
        uint256   _move = _udds[_udds.length - 1];
        _udds[_uidx] = _move;
        _deeds[nft].upos = _uidx;
        _udds.pop();
        _usrDeeds[_deeds[nft].guy] = _udds;
    }

    function _upush(address guy, uint256 nft) internal {
        _deeds[nft].upos = _usrDeeds[guy].length;
        _usrDeeds[guy].push(nft);
        _deeds[nft].guy = guy;
    }

    function approve(address guy, uint256 nft) public payable mine(nft) returns (address) {
        _deeds[nft].approved = guy;
        emit Approval(msg.sender, guy, nft);
    }

    function setApprovalForAll(address op, bool ok) public {
        _operators[msg.sender][op] = ok;
        emit ApprovalForAll(msg.sender, op, ok);
    }

    function getApproved(uint256 nft) public returns (address) {
        return _deeds[nft].approved;
    }

    function isApprovedForAll(address guy, address op) public view returns (bool) {
        return _operators[guy][op];
    }
}
