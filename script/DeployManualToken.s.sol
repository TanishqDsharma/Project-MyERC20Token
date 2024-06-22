//SPDX-License-Identifier:MIT

pragma solidity ^0.8.16;

import {Script} from    "../lib/forge-std/src/Script.sol";
import {ManualToken} from "../src/ManualToken.sol";

contract DeployManualToken is Script {
uint256 public DEFAULT_ANVIL_PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
uint256 public deployerKey;

function run() external returns(ManualToken){
    if (block.chainid == 31337) {
        deployerKey = DEFAULT_ANVIL_PRIVATE_KEY;
    } else {
        deployerKey = vm.envUint("PRIVATE_KEY");
    }
    vm.startBroadcast(deployerKey);
    ManualToken manualToken = new ManualToken(100);
    vm.stopBroadcast();
    return manualToken;
}

}
