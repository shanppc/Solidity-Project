// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Solidity_visibility{

string public PublicVar ="This is open for anyone";

//Only inside the contract can call & access it
string  private PrivateVar = "Secret msg";


//Only inside the contract & derived contract can access it
string internal InternalVar = "Only family";

function publicFunc() public pure returns(string memory) {
        return "Public Function ";
    }

    function privateFunc() private pure returns(string memory) {
        return "Private Function";
    }

    function internalFunc() internal pure returns(string memory) {
        return "Internal Function";
    }


//Lets call Private var
function revealMsg()public view returns (string memory) {
    return PrivateVar;
}

//  Lets  call internal Var
function GetInternalMsg() public view returns(string memory) {
    return InternalVar;
}
// can only be accessed externally (i.e. via this.f()) and are part of the contract's interface 
function externalFunc() external pure returns(string memory) {
        return "External Function";
    }


}