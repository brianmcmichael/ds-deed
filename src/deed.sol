pragma solidity ^0.5.15;

import "./base.sol";

contract DSDeed is DSDeedBase {

    constructor(string memory name, string memory symbol) DSDeedBase(name, symbol) public {}


}
