// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract StakedETH is ERC20, Ownable {
    address private stakeContractAddress;

    constructor() ERC20("Staked ETH", "sETH") Ownable(msg.sender) {}

    function mint(address to, uint256 amount) public {
        require(stakeContractAddress != address(0), "Stake contract address not set");
        require(msg.sender == stakeContractAddress, "Only stake contract can mint");
        _mint(to, amount);
    }

    function setStakeContractAddress(address _stakeContractAddress) public onlyOwner {
        stakeContractAddress = _stakeContractAddress;
    }
}
