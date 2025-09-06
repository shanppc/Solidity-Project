// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ATM {
    address public owner;              

    constructor() payable { // run once at deployment; allow contract to be created with ether
        owner = msg.sender;           
    }

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
    function withdraw(uint _amount) public returns(uint) {
        require(balances[msg.sender] >= _amount, "Insufficient Balance"); // enough funds?
        balances[msg.sender] -= _amount;     
        emit Withdraw(msg.sender, _amount);  
        payable(msg.sender).transfer(_amount); 
        return _amount;
    }

    // quick way for a user to check their stored balance
    function GetBlance() public view returns(uint) {
        return balances[msg.sender];
    }


    //  reverts if caller is not the stored owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // owner can drain entire contract balance in one call
    function WithdrawAll() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}