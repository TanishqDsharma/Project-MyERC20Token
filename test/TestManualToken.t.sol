//SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {Test,console} from "../lib/forge-std/src/Test.sol";
import {ManualToken} from "../src/ManualToken.sol";
import {DeployManualToken} from "../script/DeployManualToken.s.sol";
import {StdCheats} from "forge-std/StdCheats.sol";


contract TestManualToken is Test{
    
ManualToken manualToken;
DeployManualToken deployManualToken;
address public deployerAddress;


uint256 public constant STARTING_BALANCE=10e18;
address user = makeAddr("USER");
address user2 = makeAddr("USER2");


    function setUp() public{
        deployManualToken= new DeployManualToken();
        manualToken = deployManualToken.run();
        vm.deal(user,STARTING_BALANCE);
        deployerAddress = vm.addr(deployManualToken.deployerKey());
    }
    
    function testOnlyOwnerCanMintTokens() public{

        vm.expectRevert();
        manualToken.mint(user,200);

    }

    function testmint() public{
        console.log("Tokens before mint: ", manualToken.s_tokenSupply());
        console.log("Owner is :",manualToken.getOwner());
        vm.prank(deployerAddress);
        manualToken.mint(deployerAddress,200);
        assert(manualToken.s_tokenSupply()==300);

    }

    function testToQueryBalance() public {
          
         uint256 initialSupply =100;
          assert(initialSupply==manualToken.balanceOf(deployerAddress));
    }


    function testTransfer() public{
        vm.prank(deployerAddress);
        manualToken.mint(deployerAddress,500);
        console.log("Balance update after mint",manualToken.balanceOf(deployerAddress));
        vm.prank(deployerAddress);

        manualToken.transfer(user,300);
        assert(manualToken.balanceOf(user)==300);
        assert(manualToken.s_tokenSupply()==600);

    }

    function testBurn() public {
        vm.prank(deployerAddress);

        manualToken.mint(deployerAddress,500);
        console.log("Balance update after mint",manualToken.balanceOf(deployerAddress));
        vm.prank(deployerAddress);

        manualToken.transfer(user,300);

        vm.prank(user);
        manualToken.burn(100);
        assert(manualToken.balanceOf(user)==200);
        assert(manualToken.s_tokenSupply()==500);

    }
    
}
