# ETH Stake

A simple Ethereum staking protocol that allows users to stake ETH and earn sETH (Staked ETH) tokens as rewards.

## Overview

This project implements a basic staking mechanism where users can:
- Stake ETH to earn rewards over time
- Unstake their ETH at any time
- Claim rewards in the form of sETH tokens
- View their accumulated rewards

The protocol consists of two main contracts:
- `StakedETH`: An ERC20 token representing staking rewards
- `StakingContract`: The main staking logic contract

## Features

- **ETH Staking**: Users can stake ETH and earn rewards proportional to their stake and time
- **Flexible Unstaking**: Users can unstake any amount of their staked ETH at any time
- **Reward Tokens**: Rewards are paid out in sETH tokens at a rate of 1 sETH per ETH per second
- **Real-time Rewards**: Users can view their accumulated rewards without claiming them
- **Security**: Only the staking contract can mint sETH tokens

## Contracts

### StakedETH (sETH)
- **Type**: ERC20 Token
- **Symbol**: sETH
- **Name**: Staked ETH
- **Purpose**: Represents staking rewards earned by users

**Key Functions:**
- `mint(address to, uint256 amount)`: Mint new sETH tokens (only callable by staking contract)
- `setStakeContractAddress(address)`: Set the authorized staking contract address (owner only)

### StakingContract
- **Purpose**: Manages ETH staking, unstaking, and reward distribution

**Key Functions:**
- `stake(uint256 amount)`: Stake ETH and start earning rewards
- `unstake(uint256 amount)`: Unstake ETH and receive it back
- `claimRewards()`: Claim accumulated rewards as sETH tokens
- `getRewards()`: View current accumulated rewards without claiming

**Reward Rate:**
- 1 sETH per ETH per second staked

## Project Structure

```
├── src/
│   ├── StakedETH.sol          # ERC20 reward token contract
│   └── StakingContract.sol    # Main staking logic contract
├── test/
│   ├── StakedETH.t.sol        # Tests for StakedETH contract
│   └── StakingContract.t.sol  # Tests for StakingContract
├── lib/                       # Dependencies (OpenZeppelin, Forge)
└── foundry.toml              # Foundry configuration
```

## Getting Started

### Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation) installed

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd eth-stake
```

2. Install dependencies:
```bash
forge install
```

3. Build the contracts:
```bash
forge build
```

4. Run tests:
```bash
forge test
```

### Running Tests

Run all tests:
```bash
forge test
```

Run tests with verbose output:
```bash
forge test -vvv
```

Run specific test file:
```bash
forge test --match-path test/StakingContract.t.sol
```

## Usage Example

### Deployment Sequence

1. Deploy `StakedETH` contract
2. Deploy `StakingContract` with the `StakedETH` address
3. Call `setStakeContractAddress` on `StakedETH` with the `StakingContract` address

### User Interactions

```solidity
// Stake 1 ETH
stakingContract.stake{value: 1 ether}(1 ether);

// Wait some time for rewards to accumulate
// Check rewards (returns amount in wei)
uint256 rewards = stakingContract.getRewards();

// Claim rewards as sETH tokens
stakingContract.claimRewards();

// Unstake 0.5 ETH
stakingContract.unstake(0.5 ether);
```

## Security Considerations

- The `StakedETH` contract uses OpenZeppelin's `Ownable` for access control
- Only the designated staking contract can mint new sETH tokens
- Users can only unstake ETH they have previously staked
- Reward calculations are based on time elapsed and amount staked

## Testing

The project includes comprehensive tests covering:
- Basic staking and unstaking functionality
- Reward calculation accuracy
- Access control mechanisms
- Error conditions and edge cases

Test coverage includes:
- ✅ Initial token supply verification
- ✅ Minting restrictions (only staking contract)
- ✅ Owner-only functions
- ✅ Staking with ETH
- ✅ Unstaking validation
- ✅ Reward calculations
- ✅ Complex staking scenarios

## Dependencies

- **OpenZeppelin Contracts**: For secure, audited contract implementations
- **Forge Standard Library**: For testing utilities and cheat codes