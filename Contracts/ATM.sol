// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ATM {

    mapping(address => uint) public balances; // tracks how much each user has deposited

    event Deposit(address indexed user, uint amount);   // log every deposit
    event Withdraw(address indexed user, uint amount);  // log every withdrawal


    // let anyone add ether to their own balance
    function deposit() payable public returns(uint) {
        balances[msg.sender] += msg.value;   // increase caller’s stored balance by sent ether
        emit Deposit(msg.sender, msg.value); 
        return msg.value;                    
    }

    // let a user take ether back (up to their stored balance)
    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient Balance"); // enough funds?
        balances[msg.sender] -= _amount;  

        (bool success,) = msg.sender.call{value: _amount}("");
        require(success, "Transfer failed");

        emit Withdraw(msg.sender, _amount);  
       

    }

    // quick way for a user to check their stored balance
    function GetBlance() public view returns(uint) {
        return balances[msg.sender];
    }


}