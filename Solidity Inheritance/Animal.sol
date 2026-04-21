// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Animal {
    // --- State Variables ---
    string internal _name;
    uint8 internal _age;

    // --- Events ---
    event Spoke(address indexed who, string sound);

    // --- Constructor ---
    constructor(string memory name_, uint8 age_) {
        _name = name_;
        _age = age_;
    }

    // --- Public Getters ---
    function name() public view returns (string memory) {
      return _name;
    }

    function age() public view returns (uint8) {
        return _age;
    }

    // --- Virtual Functions (to override in children) ---
    function species() public view virtual returns (string memory) {
return "Animal";
    }

    function sound() public view virtual returns (string memory) { 
    
       return "---";
    }

    function makeSoundExternal() external virtual returns (string memory) {
        // TODO: call sound(), emit Spoke event, return the sound
    string memory s = sound();
    emit Spoke(msg.sender, s);
    return s;
    }

    // --- Internal Helper (children can use/override) ---
    function _ageInHumanYears() internal view virtual returns (uint256) {
        return _age;
    }
}
