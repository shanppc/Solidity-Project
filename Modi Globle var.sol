// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
contract owoneExp{

address public owner;

constructor(){
  owner= msg.sender;
}

modifier onlyOwner() {
    require(msg.sender==owner, "You are not the owner");
    _;
}

function whoAmi() public view returns (address) {
    return msg.sender;
}

function payMe() public payable returns (uint) {
    return msg.value; // returns the amount sent
}
 // Withdraw all funds (only owner can call)
    function withdrawAll() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
