// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract PiggyBank {
    uint public goalAmount;

 function Deposit() public payable{

 }

    // 1️⃣ Public function to set goal
    function setGoal(uint _goalInWei) public  {
        goalAmount = _goalInWei;
    }

    // 2️⃣ Private helper to multiply
    function multiply(uint a, uint b) private pure returns (uint) {
        return a * b;
    }

    // 3️⃣ View function to check balance
    function checkBalance() view public returns (uint) {
        return address(this).balance;
    }

    // 4️⃣ Pure function to add numbers
    function add(uint a, uint b) pure public returns (uint) {
        return a+b;
    }

  

    // 6️⃣ Extra: check if goal is reached
    function goalReached() view public  returns (bool) {
        return address(this).balance >= goalAmount;
    }
}
