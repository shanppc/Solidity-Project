// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MessagePortal{

string public message;

event messageUpdated(string old,string newMessage);

    constructor(string memory _initialMessage) {
        message = _initialMessage;}

    function updateMessage(string memory _newMessage) public {
       string memory old = message;
       message = _newMessage;
       emit messageUpdated(old, message);
    }


}