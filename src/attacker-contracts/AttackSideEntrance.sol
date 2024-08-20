// SPDX-License-Identifier: MIT
 pragma solidity 0.8.25;

 import "../side-entrance/SideEntranceLenderPool.sol";
 import {SafeTransferLib} from "solady/utils/SafeTransferLib.sol";

 contract AttackSideEntrance {
    SideEntranceLenderPool pool;

    constructor(address _pool, address _recovery, address _amount) {
        pool = new SideEntranceLenderPool(_pool);
        recovery = _recovery;
        amount = _amount;
    }