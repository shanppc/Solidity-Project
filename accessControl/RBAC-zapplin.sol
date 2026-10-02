// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

contract TokenManager is AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    constructor() {
     _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
     _grantRole(MINTER_ROLE, msg.sender);
    }


    function mintAction() public onlyRole(MINTER_ROLE) {
        
    }

    function pauseAction() external onlyRole(PAUSER_ROLE) {

    }

    function isMinter(address _account) public view returns(bool) {
        return hasRole(MINTER_ROLE, _account);
    }

    function isPauser(address _account) public view returns (bool) {
        return hasRole(PAUSER_ROLE, _account);
    }


}