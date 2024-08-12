// SPDX-L:License-Identifier: MIT;

pragma solidity ^0.8.0;

import "../truster/TrusterLenderPool.sol"; 
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AttackTruster {
    TrusterLenderPool public pool;
    IERC20 public token;
}