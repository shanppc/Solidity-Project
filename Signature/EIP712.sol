// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract EIP712SignatureVerifier {
    address public owner;

   mapping (address=> uint256 ) public nonces;

   bytes32 public constant AUTHORIZATION_TYPEHASH = keccak256("Authorization(address recipient,uint256 amount,uint256 nonce)");

    constructor() {
        owner = msg.sender;
    }

    function getDomainSeparator() public view returns (bytes32) {
        bytes32 DOMAIN_TYPEHASH = keccak256(
            "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
        );

        return keccak256(
            abi.encode(
                DOMAIN_TYPEHASH,
                keccak256(bytes("SignatureVerifier")),
                keccak256(bytes("1")),
                block.chainid,
                address(this)
            )
        );
    }

    function getAuthorizationStructHash( address recipient, uint256 amount, uint256 nonce) public pure returns (bytes32) {
    return keccak256(abi.encode(AUTHORIZATION_TYPEHASH, recipient, amount, nonce));
     }

    function getTypedDataHash(address recipient, uint256 amount, uint256 nonce) public view returns(bytes32) {
     return keccak256(abi.encodePacked(
        "\x19\x01",
        getDomainSeparator(),
        getAuthorizationStructHash(recipient, amount, nonce)
       )
      );
    }

    function recoverEIP712Signer(bytes32 digest, uint8 v, bytes32 r, bytes32 s) public pure returns (address) {
    return ecrecover(digest, v, r, s); }

}