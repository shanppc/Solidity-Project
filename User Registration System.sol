// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract signup{

    struct User{
      string name;
      uint age;
      bool isStudent;
      bytes customData;
      address wallet;   
    }

    mapping (address=>User) public users;

    function regUser(string memory _name, uint _age, bool _Is_Student, bytes memory _Data) public {
users[msg.sender] = User({
            name: _name,
            age: _age,
            isStudent: _Is_Student,
            customData: _Data,
            wallet: msg.sender         // Store the caller's address
        });

    }

    function upadte_name(string memory new_name) public {

users[msg.sender].name = new_name;}

function deletename() public {
  users[msg.sender].name = ""; // Set name to empty string;
}

function deleteAllData() public {
  delete users[msg.sender];
}}