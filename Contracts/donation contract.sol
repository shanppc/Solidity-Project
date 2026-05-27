// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Donation{
    uint256 public totalDonations;
    address public immutable owner;

    event Donated(address doner, uint amount);
    event Withdraw(uint amount);

  constructor(){
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender==owner,"Not Owner");
    _;
  }

   receive() external payable {
    totalDonations += msg.value;

    emit Donated(msg.sender, msg.value);
    }

   function withdraw() public onlyOwner{
    uint256 balance = address(this).balance;
    require(balance > 0,"No funds");

    (bool success, ) = payable(owner).call{value: balance}("");
    require(success," withdraw failed");

     emit Withdraw(balance);
               }     
}