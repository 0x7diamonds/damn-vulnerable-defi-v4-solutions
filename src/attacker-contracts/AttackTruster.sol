// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {DamnValuableToken} from "../../src/DamnValuableToken.sol";
import {TrusterLenderPool} from "../../src/truster/TrusterLenderPool.sol";
contract AttackTruster {

    DamnValuableToken public token;
    TrusterLenderPool public pool;
    address public recovery;

    constructor(address _token, address _pool, address _recovery) {
        token = DamnValuableToken(_token);
        pool = TrusterLenderPool(_pool);
        recovery = _recovery;
    }

    function attack() external {
        require(
            poolflashLoan
            ()
        )
    }
}