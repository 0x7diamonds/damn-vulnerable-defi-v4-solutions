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
    DamnValuableVotes damnValueToken;
    uint actionId;
}