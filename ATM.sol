// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ATM{
    address public owner;
    constructor() payable {
        owner = msg.sender;
    }
 mapping(address=> uint) public balances;
event Deposit(address indexed user, uint amount);
event Withdraw(address indexed user, uint amount);


function deposit() payable public returns(uint) {
    balances[msg.sender] += msg.value; // store deposited amount
    emit Deposit(msg.sender, msg.value);

    return msg.value;
}
   
 function withdraw(uint _amount) public returns(uint) {
 require(balances[msg.sender]>= _amount, "Insufficient Balance");
 balances[msg.sender] -= _amount; // reduce balance
emit Withdraw(msg.sender, _amount);

 payable(msg.sender).transfer(_amount);
 return _amount;}

 function GetBlance() public view returns(uint){
    return balances[msg.sender];
 }
 modifier onlyOwner() {
    require(msg.sender == owner, "Not owner");
    _;
}

function WithdrawAll() public onlyOwner {
    payable(owner).transfer(address(this).balance);
}
}