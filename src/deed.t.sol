pragma solidity >=0.4.20;

import "ds-test/test.sol";

import "./deed.sol";

contract DSDeedTest is DSTest {
    DSDeed deed;

    string  _name = "TestToken";
    string  _symb = "TEST";
    address _addr = 0x00000000219ab540356cBB839Cbe05303d7705Fa;
    string  _uri  = "https://etherscan.io/address/0x00000000219ab540356cBB839Cbe05303d7705Fa";

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

    function testTotalSupply() public {
        deed.mint(_addr, _uri);
        deed.mint(_addr, "t2"); //setup

        assertEq(deed.totalSupply(), 2);
        deed.mint(_addr, "t3");
        deed.mint(_addr, "t4");
        assertEq(deed.totalSupply(), 4);
        deed.burn(0);
        assertEq(deed.totalSupply(), 3);
        deed.burn(1);
        assertEq(deed.totalSupply(), 2);
        deed.burn(2);
        assertEq(deed.totalSupply(), 1);
        deed.burn(3);
        assertEq(deed.totalSupply(), 0);
    }

    //function tokenByIndex(uint256 idx) external view returns (uint256);
    //function tokenOfOwnerByIndex(address guy, uint256 idx) external view returns (uint256);

    // Test fail when burning a burned nft
}
