// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/StakingContract.sol";
import "src/StakedETH.sol";

contract StakingContractTest is Test {
    StakingContract sContract;
    StakedETH sETH;

    function setUp() public {
        sETH = new StakedETH();
        sContract = new StakingContract(IStakedETH(address(sETH)));
        sETH.setStakeContractAddress(address(sContract));
    }

    function testStake() public {
        uint value = 10 ether;
        sContract.stake{value: value}(value);

        assert(sContract.totalStake() == value);
    }

    function test_RevertWhen_InsufficientBalance() public {
        uint value = 10 ether;
        sContract.stake{value: value}(value);
        vm.expectRevert("Insufficient staked amount");
        sContract.unstake(value + 1 ether);
    }

    function test_RevertWhen_ETHAmountMismatch() public {
        uint value = 10 ether;
        vm.expectRevert("ETH amount mismatch");
        sContract.stake{value: 5 ether}(value);
    }

    function testGetRewards() public {
        uint value = 1 ether;
        sContract.stake{value: value}(value);
        vm.warp(block.timestamp + 1);
        uint rewards = sContract.getRewards();

        assert(rewards == 1 ether);
    }

    function testComplexGetRewards() public {
        uint value = 1 ether;
        sContract.stake{value: value}(value);
        vm.warp(block.timestamp + 1);
        sContract.stake{value: value}(value);
        vm.warp(block.timestamp + 1);
        uint rewards = sContract.getRewards();

        assert(rewards == 3 ether);
    }

    function testRedeemRewards() public {
        uint value = 1 ether;
        sContract.stake{value: value}(value);
        vm.warp(block.timestamp + 1);
        sContract.claimRewards();

        assert(sETH.balanceOf(address(this)) == 1 ether);
    }
}