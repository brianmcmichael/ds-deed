pragma solidity ^0.5.15;

import "ds-test/test.sol";

import "./deed.sol";

contract DsDeedTest is DSTest {
    DsDeed deed;

    function setUp() public {
        deed = new DsDeed();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
