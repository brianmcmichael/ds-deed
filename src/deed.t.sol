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

    // ERC721 Metadata

    function testName() public {
        assertEq(deed.name(), _name);
    }

    function testSymbol() public {
        assertEq(deed.symbol(), _symb);
    }

    function testTokenURI() public {
        deed.mint(_addr, _uri);  //setup

        assertEq(deed.tokenURI(0), _uri);
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
