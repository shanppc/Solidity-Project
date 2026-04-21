// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Base contract
contract OwnerBox {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Modifier for onlyOwner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Change owner
    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
}

// Extended Roles contract
contract RolesContract is OwnerBox {
    address public admin;

    // Set admin (only owner can set)
    function setAdmin(address admin_address) public onlyOwner {
        admin = admin_address;
    }

    // Admin-only task
    function adminTask() public view returns (string memory) {
        require(msg.sender == admin, "Only admin can call this");
        return " Admin task executed!";
    }

    // Owner-only task
    function ownerTask() public view onlyOwner returns (string memory) {
        return " Owner task executed!";
    }
}
