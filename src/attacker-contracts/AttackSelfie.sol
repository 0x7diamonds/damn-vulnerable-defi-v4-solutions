// SPDX-License-Identifier: MIT

pragma solidity =0.8.25;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC3156FlashBorrower.sol";

interface IPool {
    function flashLoan(
        IERC3156FlashBorrower _receiver,
        address _token,
        uint256 _amount,
        bytes calldata data
    ) external returns (bool);
}

interface IGovernance {
    function queueAction(
        address target,
        uint128 value,
        bytes calldata data
    ) external returns (uint256 actionId);
    function getActionCounter() external returns (uint256);
}

interface IERC20Snapshot is IERC20 {
    function snapshot() external returns(uint256);
}

contract AttackSelfie {
    
}