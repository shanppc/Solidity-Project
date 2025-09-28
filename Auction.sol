// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract BlindAuction{
    address public owner;
    uint public highestBid;
    address public highestBidder;
    uint public AuctionEndTime;
    uint public minBid;
    bool public ended;
    mapping(address => uint) public pendingReturns;

    event NewBid(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    constructor(uint _MinBidInFinny, uint _DurationInHours) {
        minBid = _MinBidInFinny * 1000 gwei; // 1 finney = 1000 gwei
        AuctionEndTime = block.timestamp + (_DurationInHours * 1 hours);
        require(_DurationInHours > 0, "Auction must last more than 0 hours");
        owner = msg.sender;
    }

    // Secure bid function (reentrancy-protected)
    function bid() external payable{
        require(!ended, "Auction already ended");
        require(block.timestamp < AuctionEndTime, "Auction Time Ended");
        require(msg.value >= minBid, "Bid < minBid");
        require(msg.value > highestBid, "Bid not high enough");

        // Update state BEFORE external calls (Checks-Effects-Interactions)
        if (highestBid > 0) {
            pendingReturns[highestBidder] += highestBid; // Track refunds (pull pattern)
        }
        highestBid = msg.value;
        highestBidder = msg.sender;

        emit NewBid(msg.sender, msg.value);
    }

    // End auction (only owner)
    function auctionEnd() external {
        require(block.timestamp >= AuctionEndTime, "Auction not yet ended");
        require(!ended, "Auction already ended");
        ended = true;

        emit AuctionEnded(highestBidder, highestBid);
    }

    // Withdraw refunds (pull pattern)
    function withdrawRefund() external {
        uint amount = pendingReturns[msg.sender];
        require(amount > 0, "No refund available");
        pendingReturns[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }

   function withdrawOwner() external {
    require(ended, "Auction not ended");
    require(msg.sender == owner, "Not the owner");
    uint amount = highestBid;
    highestBid = 0; // prevent double-withdraw
    (bool success, ) = owner.call{value: amount}("");
    require(success, "Transfer failed");
}

    
}