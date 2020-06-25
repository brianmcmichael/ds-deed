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

contract DSDeedBase is ERC721, ERC721Enumerable {

    constructor() public {

    }

    function totalSupply() public view returns (uint256) {

    }

    function tokenByIndex(uint256 idx) public view returns (uint256) {

    }

    function tokenOfOwnerByIndex(address guy, uint256 idx) public view returns (uint256) {

    }

    function onERC721Received(address op, address src, uint256 nft, bytes what) external returns(bytes4) {

    }

    function supportsInterface(bytes4 interfaceID) external view returns (bool) {

    }

    function balanceOf(address guy) public view returns (uint256) {

    }

    function ownerOf(uint256 nft) public view returns (address) {

    }

    function safeTransferFrom(address src, address dst, uint256 nft, bytes what) public payable {

    }

    function safeTransferFrom(address src, address dst, uint256 nft) public payable {

    }

    function transferFrom(address src, address dst, uint256 nft) public payable {

    }

    function approve(address guy, uint256 nft) public payable returns (address) {

    }

    function setApprovalForAll(address op, bool ok) public {

    }

    function getApproved(uint256 nft) public returns (address) {

    }

    function isApprovedForAll(address guy, address op) public view returns (bool) {

    }
}
