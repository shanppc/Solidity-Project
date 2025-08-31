// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Dog.sol";

 contract Bulldog is Dog{
        uint8 public droolLevel; // 0-10

    constructor(
       string memory _name,
        uint8 _age,
        uint8 droolLevel_) Dog(_name, _age) {
        require(droolLevel_ <= 10, "drool: 0..10");
        droolLevel = droolLevel_;
    }
    function species() public pure override returns (string memory) {
        return "German Shepherd (Bulldog)";
    }

function sound() public override pure  returns(string memory) {
return "Gruff";
}
function _ageInHumanYears() internal view override returns (uint256) {
    if (_age <= 2) return uint256(_age) * 12;
    return 24 + (uint256(_age) - 2) * 6;
}

function humanYears() public view override returns (uint256) {
    return _ageInHumanYears();
}


}