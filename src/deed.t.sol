pragma solidity >=0.4.20;

import "ds-test/test.sol";

import "./deed.sol";

contract DSDeedTest is DSTest {
    DSDeed deed;

    function setUp() public {
        deed = new DSDeed("TestToken", "TEST");
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
