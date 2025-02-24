# Side Entrance

A surprisingly simple pool allows anyone to deposit ETH, and withdraw it at any point in time.

It has 1000 ETH in balance already, and is offering free flashloans using the deposited ETH to promote their system.

Yoy start with 1 ETH in balance. Pass the challenge by rescuing all ETH from the pool and depositing it in the designated recovery account.

Possible ways to exploit the contract:
- Via `depostt` and `withdraw` function
    - Exploit the address like challenge 2
    - Using `approve` like challenge 3
- Via `flashloan` function
    - Front-running attack
=> Thoughts: Can we `flashloan` 1000 eth and then call `withdraw` function? Any reverts?
