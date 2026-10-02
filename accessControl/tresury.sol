// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract  Treasury{
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not Owner");
        _;
    }

    function deposit() public payable {
    }

    function withdraw(uint256 _amount) public onlyOwner {
        require(_amount <= address(this).balance);

        (bool ok, ) = owner.call{value: _amount}("");
        require(ok, "failed"); 
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "zero address");
        owner = _newOwner;
    }

    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }
} 