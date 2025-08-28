// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OwnerVault {
    address public owner;
    mapping(address => uint) public deposits;

    constructor() {
        owner = msg.sender; // set the deployer as owner
    }

    // 1️⃣ Modifier: onlyOwner
    modifier onlyOwner() {
        require(msg.sender ==owner, "Not the owner");
        _;
    }

    // 2️⃣ Payable deposit function
    function deposit() public payable {
        require(msg.value > 0, "Send some ETH");
        deposits[msg.sender] += msg.value;
    }

    // 3️⃣ View function to check your deposit
    function myDeposit() public view returns (uint) {
        return deposits[msg.sender];
    }

    // 4️⃣ View function to check total balance
    function vaultBalance() public view returns (uint) {
        return address(this).balance;
    }

    // 5️⃣ Withdraw all funds (only owner)
    function withdrawAll() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
