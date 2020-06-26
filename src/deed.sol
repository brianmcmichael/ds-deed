pragma solidity >0.4.20;

import "./base.sol";

contract DSDeed is DSDeedBase {

    constructor(string memory name, string memory symbol) DSDeedBase(name, symbol) public {}


}
