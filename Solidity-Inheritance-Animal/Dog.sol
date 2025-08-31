// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Animal.sol";

contract Dog is Animal{
    constructor(string memory _name, uint8 _age) Animal(_name, _age){

    }

  function species() public view virtual override returns (string memory) {
  return "Bull Dog";
  }

  function sound() public view virtual override returns (string memory) {
    return "Bark";
  }
  function makeSoundExternal()  external override returns (string memory) {
   string memory s = sound();
    string memory withWag = string(abi.encodePacked(s, " (wagging tail)"));
    emit Spoke(msg.sender, withWag);
    return withWag;
  }
  function _ageInHumanYears()  internal override virtual view returns (uint) {
  return uint(_age) * 7;
  }
  function humanYears() public view virtual  returns (uint256) {
    return _ageInHumanYears();
}}