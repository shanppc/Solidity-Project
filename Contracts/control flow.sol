// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract flow{

    address public Owner;
constructor() payable {
Owner = msg.sender;
}

    function CheckWithdraw(uint _amount) view public returns(string memory){
        if(_amount <= address(msg.sender).balance){
            return "you can withdraw";
        }
        else{
            return "you can not withdraw";
        }
    } 

error InsufficientBalance(uint requested, uint avaliable);
function withdraw(uint amount) public view {
    if(amount > address(msg.sender).balance){
        revert InsufficientBalance(amount, address(msg.sender).balance);
    }
}

function subtractArray(uint[] memory numbers) public pure returns(uint) {
    uint result = 100;
    for(uint i = 0; i < numbers.length; i++) {
        result -= numbers[i];
    }
    return result;
}

function checkage(uint _age) public pure returns(string memory){
if (_age>= 18){
    return "you are an Adult";
}
else {
    return "you are underage";
}
}
function sumEven(uint[] memory numbers) public pure returns(uint) {
    uint result = 0;
    for(uint i = 0; i < numbers.length; i++) {
        if(numbers[i] % 2 == 0) {
            result += numbers[i];  // add even number to result
        }
    }
    return result;
}


error NotOwner(address caller);

function onlyOwnerAction() public view  {
    if(msg.sender!= Owner){
revert NotOwner(msg.sender);

    }
}
}