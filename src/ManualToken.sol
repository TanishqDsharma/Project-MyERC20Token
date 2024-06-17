pragma solidity ^0.8.16;

contract ManualToken {

    //Is used to store the total supply of the token. It is defined as public and can be queried by anyone.
    uint256 public s_tokenSupply ;

    // This address will be responsible for controlling minting and token circulation. 
    address private s_owner; 
    
    //To track token balances efficiently: we are using mapping to store the balance corresponding to each address
    mapping (address => uint) name;

    constructor(){
        s_owner=msg.sender;
    }

}