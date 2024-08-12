// SPDX-L:License-Identifier: MIT;

pragma solidity ^0.8.0;

import "../truster/TrusterLenderPool.sol"; 
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AttackTruster {
    function attack(IERC20 token, TrusterLenderPool pool) public {
        uint256 poolBalance = token.balanceOf(address(pool));

        
    }
}