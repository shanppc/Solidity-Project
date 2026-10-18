// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract MockOracle {
    address public immutable owner;
    uint8 public constant decimals = 8;
    int256 public latestPrice;
    uint64 public lastUpdatedAt;
    
    constructor(int256 _latestPrice){ 
        owner = msg.sender;
        latestPrice = _latestPrice;
        lastUpdatedAt = uint64(block.timestamp);

        emit PriceUpdated(0, latestPrice, lastUpdatedAt, msg.sender);
        }

        event PriceUpdated(int256 PrevPrice, int256 UpdatedPrice, uint256 UpdatedAt, address indexed UpdatedBy);

    modifier onlyOwner() {
        require(msg.sender == owner, "not Owner");
        _;
    }

    function setPrice(int256 newPrice) external onlyOwner {
        require(newPrice > 0, "Price must be positive");

        int256 previousPrice = latestPrice;

        latestPrice = newPrice;
        lastUpdatedAt = uint64(block.timestamp);

        emit PriceUpdated(
            previousPrice,
            newPrice,
            block.timestamp,
            msg.sender
        );
    }

    function getPrice() external view returns (int256 price, uint256 updatedAt){
        return (latestPrice, lastUpdatedAt);
    }
}
