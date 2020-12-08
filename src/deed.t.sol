pragma solidity >=0.4.20;

import "ds-test/test.sol";

import "./deed.sol";

contract DSDeedTest is DSTest {
    DSDeed deed;

    string  _name  = "TestToken";
    string  _symb  = "TEST";
    address _addr  = 0x00000000219ab540356cBB839Cbe05303d7705Fa;
    address _addr2 = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    string  _uri   = "https://etherscan.io/address/0x00000000219ab540356cBB839Cbe05303d7705Fa";

    function setUp() public {
        deed = new DSDeed(_name, _symb);
    }

    function testMint() public {
        assertEq(deed.totalSupply(), 0);

        deed.mint(_addr, _uri);

        assertEq(deed.totalSupply(), 1);
    }

    function testMintMany() public {
        assertEq(deed.totalSupply(), 0);

        deed.mint(_addr, _uri);
        deed.mint(_addr, "t1");
        deed.mint(_addr, "t2");
        deed.mint(_addr, "t3");
        deed.mint(_addr, "t4");
        deed.mint(_addr, "t5");
        deed.mint(_addr, "t6");
        deed.mint(_addr, "t7");
        deed.mint(_addr, "t8");

        assertEq(deed.totalSupply(), 9);
        assertEq(deed.tokenURI(8), "t8");

    }

    function testBurn() public {
        deed.mint(_addr, _uri);
        assertEq(deed.totalSupply(), 1); // setup

        deed.burn(0);
        assertEq(deed.totalSupply(), 0);
    }

    function testBurnMany() public {
        deed.mint(_addr, _uri);
        deed.mint(_addr, "t1");
        deed.mint(_addr, "t2");
        deed.mint(_addr, "t3");
        deed.mint(_addr, "t4");
        deed.mint(_addr, "t5");
        deed.mint(_addr, "t6");
        deed.mint(_addr, "t7");
        deed.mint(_addr, "t8");
        assertEq(deed.totalSupply(), 9);  // setup

        deed.burn(7);
        assertEq(deed.totalSupply(), 8);
        assertEq(deed.ownerOf(6), _addr);
        deed.burn(6);
        deed.burn(2);
        deed.burn(8);
        deed.burn(1);

    }


    // ERC721 Metadata

    function testName() public {
        assertEq(deed.name(), _name);
    }

    function testSymbol() public {
        assertEq(deed.symbol(), _symb);
    }

    function testTokenURI() public {
        deed.mint(_addr, _uri);  //setup
        deed.mint(_addr, "t2");

        assertEq(deed.tokenURI(0), _uri);
        assertEq(deed.tokenURI(1), "t2");
    }

    // ERC721 Enumerable

    /// notice Count NFTs tracked by this contract
    /// return A count of valid NFTs tracked by this contract, where each one of
    ///  them has an assigned and queryable owner not equal to the zero address
    function testTotalSupply() public {
        deed.mint(_addr, _uri);
        deed.mint(_addr, "t2"); //setup

        assertEq(deed.totalSupply(), 2);
        deed.mint(_addr, "t3");
        deed.mint(_addr2, "t4");
        assertEq(deed.totalSupply(), 4);
        deed.burn(0);
        assertEq(deed.totalSupply(), 3);
        deed.burn(1);
        assertEq(deed.totalSupply(), 2);
        deed.burn(2);
        assertEq(deed.totalSupply(), 1);
        deed.mint(_addr, "t5");
        assertEq(deed.totalSupply(), 2);
        assertEq(deed.balanceOf(_addr), 1);
        assertEq(deed.balanceOf(_addr2), 1);
        deed.burn(3);
        assertEq(deed.totalSupply(), 1);
        assertEq(deed.balanceOf(_addr), 1);
        assertEq(deed.balanceOf(_addr2), 0);
    }

    //function tokenByIndex(uint256 idx) external view returns (uint256);
    /// notice Enumerate valid NFTs
    /// dev Throws if `_index` >= `totalSupply()`.
    /// param _index A counter less than `totalSupply()`
    /// return The token identifier for the `_index`th NFT,
    ///  (sort order not specified)
    function testTokenByIndex() public {
        deed.mint(_addr, _uri);
        deed.mint(_addr,  "t1");
        deed.mint(_addr,  "t2");
        deed.mint(_addr2, "t3");
        deed.mint(_addr2, "t4");
        deed.mint(_addr2, "t5");
        deed.mint(_addr,  "t6");

        assertEq(deed.tokenByIndex(4), 4);
        deed.burn(4);
        assertEq(deed.tokenByIndex(3), 3);
        assertEq(deed.tokenByIndex(4), 6);
        deed.burn(3);
        assertEq(deed.tokenByIndex(3), 5);
        assertEq(deed.tokenByIndex(4), 6);
        deed.burn(0);
        assertEq(deed.tokenByIndex(0), 6);
        assertEq(deed.tokenByIndex(1), 1);
    }

    //function tokenOfOwnerByIndex(address guy, uint256 idx) external view returns (uint256);
    /// notice Enumerate NFTs assigned to an owner
    /// dev Throws if `_index` >= `balanceOf(_owner)` or if
    ///  `_owner` is the zero address, representing invalid NFTs.
    /// param guy An address where we are interested in NFTs owned by them
    /// param idx A counter less than `balanceOf(_owner)`
    /// return The token identifier for the `_index`th NFT assigned to `_owner`,
    ///   (sort order not specified)
    function testTokenOfOwnerByIndex() public {
        deed.mint(_addr, _uri);
        deed.mint(_addr,  "t1");
        deed.mint(_addr,  "t2");
        deed.mint(_addr2, "t3");
        deed.mint(_addr2, "t4");
        deed.mint(_addr2, "t5");
        deed.mint(_addr,  "t6");

        assertEq(deed.tokenOfOwnerByIndex(_addr, 0), 0);
        assertEq(deed.tokenOfOwnerByIndex(_addr, 2), 2);
        assertEq(deed.tokenOfOwnerByIndex(_addr, 3), 6);

        assertEq(deed.tokenOfOwnerByIndex(_addr2, 0), 3);
        assertEq(deed.tokenOfOwnerByIndex(_addr2, 1), 4);
    }

    function testFailTokenOfOwnerByIndex() public {
        deed.mint(_addr, _uri);
        deed.mint(_addr,  "t1");
        deed.mint(_addr,  "t2");

        deed.tokenOfOwnerByIndex(_addr, 3); // max 2
    }
    // Test fail when burning a burned nft
}
