// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract  RBAC{
    address public owner;

    event ActionExecuted(string action, address caller);

    constructor() {
        owner = msg.sender;
    }

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    mapping (bytes32 => mapping (address => bool)) public roles;

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    modifier onlyRole(bytes32 role) {
        require(roles[role][msg.sender], "no role");
        _;
    }

    function grantRole(bytes32 _role, address _account) public onlyOwner {
        require(_account != address(0), "zero address");

        roles[_role][_account] = true;
    }

    function revokeRole(bytes32 _role, address _account) public onlyOwner {
        require(roles[_role][_account], "no role for this acount");

        roles[_role][_account] = false;
    }

    function adminAction() public onlyRole(ADMIN_ROLE) {
        emit ActionExecuted("ADMIN", msg.sender);
    }

    function mintAction() public onlyRole(MINTER_ROLE) {
        emit ActionExecuted("MINT", msg.sender);
    }

    function pauseAction() public onlyRole(PAUSER_ROLE) {
        emit ActionExecuted("PAUSE", msg.sender);
    }

    function hasRole(bytes32 _role, address _account) public view returns(bool) {
        return roles[_role][_account];
    }

} 