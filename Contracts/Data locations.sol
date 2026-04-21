// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Data_Location{
//  store in blockchain
  string  public StoredData = "Permanent in storage";
    //Using memory (Temp text)
function GetMemory(string memory newMsg) public view returns(string memory ) {
string memory tempText= StoredData;
tempText = newMsg;
return StoredData;
}

  // Using storage (permanent change)
    function changeWithStorage(string memory newText) public {
        StoredData = newText; // Updates blockchain state
    }

    function readWithCallData(string calldata inputtext) public pure returns(string memory) {
    return inputtext; // Returns the input directly without modifying blockchain state}

}}
