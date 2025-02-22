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

    function attack() external returns(bool) {
        pool.flashLoan()
    }
}