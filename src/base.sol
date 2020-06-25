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

    string private _name;
    string private _symbol;

    mapping (uint256 => string) _uris;

    mapping (bytes4 => bool) private _interfaces;

    uint256[]                      private  _allDeeds;
    mapping (address => uint256[]) private  _usrDeeds;
    mapping (uint256 => Deed)      private  _deeds;

    struct Deed {
        uint256  pos;
        uint256 upos;
        address  guy;
    }

    constructor(string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;
        _addInterface(0x80ac58cd); // ERC721
        _addInterface(0x5b5e139f); // ERC721Metadata
        _addInterface(0x780e9d63); // ERC721Enumerable
    }

    function name() public view returns (string) {
        return _name;
    }

    function symbol() public view returns (string) {
        return _symbol;
    }

    function tokenURI(uint256 nft) external view returns (string) {
        return _uris[nft];
    }

    function totalSupply() public view returns (uint256) {
        return _allDeeds.length();
    }

    function tokenByIndex(uint256 idx) public view returns (uint256) {
        return _allDeeds[idx];
    }

    function tokenOfOwnerByIndex(address guy, uint256 idx) public view returns (uint256) {
        return _usrDeeds[address][idx];
    }

    function onERC721Received(address op, address src, uint256 nft, bytes what) external returns(bytes4) {
        //TODO
    }

    function supportsInterface(bytes4 interfaceID) external view returns (bool) {
        return _interfaces[interfaceID];
    }

    function _addInterface(bytes4 interfaceID) private {
        _interfaces[interfaceID] = true;
    }

    function balanceOf(address guy) public view returns (uint256) {
        return _usrDeeds[guy].length;
    }

    function ownerOf(uint256 nft) public view returns (address) {
        return _deeds[nft].guy;
    }

    function safeTransferFrom(address src, address dst, uint256 nft, bytes what) public payable {
        //TODO
    }

    function safeTransferFrom(address src, address dst, uint256 nft) public payable {
        //TODO
    }

    function transferFrom(address src, address dst, uint256 nft) public payable {
        //TODO
    }

    function approve(address guy, uint256 nft) public payable returns (address) {
        //TODO
    }

    function setApprovalForAll(address op, bool ok) public {
        //TODO
    }

    function getApproved(uint256 nft) public returns (address) {
        //TODO
    }

    function isApprovedForAll(address guy, address op) public view returns (bool) {
        //TODO
    }
}
