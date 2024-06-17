//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol" ;

contract MyToken is ERC20{
    constructor() ERC20("LOLCoin","LOL") {
        _mint(msg.sender,1000e18);
    }
}