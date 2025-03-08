// SPDX-License-Identifier: MIT
pragma solidity =0.8.25;

import {FreeRiderRecoveryManager} from "../free-rider/FreeRiderRecoveryManager.sol";
import {FreeRiderNFTMarketplace} from "../free-rider/FreeRiderNFTMarketplace.sol";
import {IUniswapV2Pair} from "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";

contract AttackFreeRider {
    IUniswapV2Pair pair;
    FreeRiderNFTMarketplace marketplace;
    FreeRiderRecoveryManager recoveryManager;

    constructor(
        IUniswapV2Pair _pair,
        FreeRiderNFTMarketplace _marketplace,
        FreeRiderRecoveryManager _recoveryManager
    ) {
        pair = IUniswapV2Pair(_pair);
        marketplace = FreeRiderNFTMarketplace(_marketplace);
        recoveryManager =FreeRiderRecoveryManager(_recoveryManager);
    }
}