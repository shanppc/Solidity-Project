// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicWallet {
    address public owner;
    uint public totalDeposits;

    // Events
    event Deposit(address indexed user, uint amount, uint timestamp);
    event Withdraw(address indexed user, uint amount, uint timestamp);
 
    constructor() {
        owner = msg.sender; // sets deployer as owner
    }

    // Deposit function
    function deposit() external payable {
        require(msg.value > 0, "Value must be greater than zero");

        totalDeposits += msg.value;

        // totalDeposits must never be less than the previous total
        assert(totalDeposits >= msg.value);
        
        // Trigger event here
        emit Deposit(msg.sender, msg.value, block.timestamp); // Event
    }

    // Function to withdraw money   
    function withdraw(uint _amount) external {
        require(msg.sender == owner, "You are not the owner");
        require(_amount > 0, "Amount must be greater than zero");
        require(_amount <= address(this).balance, "Not enough balance in the wallet"); // Revert

        totalDeposits -= _amount; // Update total deposits before transfer
        payable(owner).transfer(_amount);
        
        // Trigger Withdraw event here
        emit Withdraw(msg.sender, _amount, block.timestamp);
    }

    function checkOwner() external view returns (bool) {
        // should always be true -> if not, contract is broken
        assert(owner != address(0)); // assert
        return true;
    }

    function checkbalance() public view returns(uint)
    {
        return address(this).balance;
    }
}