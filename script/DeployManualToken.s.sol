//SPDX-License-Identifier:MIT

pragma solidity ^0.8.16;

import {Script} from    "../lib/forge-std/src/Script.sol";
import {ManualToken} from "../src/ManualToken.sol";

contract DeployManualToken is Script {

ManualToken manualToken;

function run() external returns(ManualToken){
    vm.startBroadcast();
    manualToken = new ManualToken(10000);
    vm.stopBroadcast();
    return manualToken;
}

}