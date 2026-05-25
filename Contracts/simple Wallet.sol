// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Wallet{

    mapping(address => uint256) public balances;

    event Deposited(address indexed user, uint256 amount);
    event Withdraw(address user, uint256 amount);

  receive() external  payable {
    balances[msg.sender] += msg.value;
    emit Deposited(msg.sender, msg.value);
 }

   function withdraw(uint amount) public {
    require(balances[msg.sender] >= amount, "Insufficient Balance");

       (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Failed to send Ether");

        emit Withdraw(msg.sender, amount);
       }
}
