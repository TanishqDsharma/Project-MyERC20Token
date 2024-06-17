pragma solidity ^0.8.16;

import {Script} from "../lib/forge-std/src/Script.sol";
import {MyToken} from "../src/MyToken.sol";


contract DeployMyToken is Script{
MyToken myToken;
    function Run() external returns(MyToken){
        vm.startBroadcast();
        myToken = new MyToken();
        vm.stopBroadcast();
        return myToken;
    }
 
}