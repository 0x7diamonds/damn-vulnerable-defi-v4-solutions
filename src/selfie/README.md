# Selfie

A new lending pool has launched! It’s now offering flash loans of DVT tokens. It even includes a fancy governance mechanism to control it.

What could go wrong, right ?

You start with no DVT tokens in balance, and the pool has 1.5 million at risk.

Rescue all funds from the pool and deposit them into the designated recovery account.

@audit goal: `flashloan` an amount above half of `totalSupply` to gain enough votes.
Step 1: Call `flashloan` function to gain all DVT tokens => `flashloan` triggers `onFlashloan` function
Step 2: Now the attacker has fulfilled the condition to become the governance, On `onFlashloan` function, delegating the governance to attacker's contract.
Step 3: Queue for `emergencyExit` after the loan has been repaid.
Step 4: The flashloan has ended but the governance attack remains in effect.
Step 5: Transfering the fund to the recovery account.
