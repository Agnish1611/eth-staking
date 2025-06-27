// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/StakedETH.sol";

contract TestContract is Test {
    StakedETH sETH;

    function setUp() public {
        sETH = new StakedETH();
    }

    function testInitialSupply() view public {
        assert(sETH.totalSupply() == 0);
    }

    function test_RevertWhen_SetStakeContractAddress_CalledByNonOwner() public {
        address stakeContract = address(0x123);
        vm.prank(address(0x456));
        vm.expectRevert();
        sETH.setStakeContractAddress(stakeContract);
    }

    function test_RevertWhen_Minting_CalledByNonStakeContract() public {
        vm.prank(address(0x123));
        vm.expectRevert();
        sETH.mint(address(0x456), 1000);
    }

    function testMinting() public {
        address stakeContract = address(0x123);
        sETH.setStakeContractAddress(stakeContract);

        address recipient = address(0x456);
        uint256 amount = 1000;
        vm.prank(stakeContract);
        sETH.mint(recipient, amount);

        assert(sETH.balanceOf(recipient) == amount);
    }
}
