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

contract AttackSelfie is IERC3156FlashBorrower {
    IPool public pool;
    IGovernance public governance;
    IERC20Snapshot public token;
    address public player;
    uint256 public amount = 1500000 ether;

    constructor(
        address _pool,
        address _governance,
        address _token,
        address _player
    ) {
        pool = IPool(_pool);
        governance = IGovernance(_governance),
        token = IERC20Snapshot(_token),
        player = _player
    }

}