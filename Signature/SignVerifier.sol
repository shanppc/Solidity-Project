// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract SignatureVerifier {
    address public owner;
    mapping (address => uint256 ) public nonces;

    constructor() {
        owner = msg.sender;
    }

    event AuthorizationExecuted(
    address indexed recipient,
    uint256 amount,
    uint256 nonce);

    // 1. Create the original message hash
    function getHash( address _recipient, uint256 _amount, uint256 _nonce) public pure returns (bytes32) {
    return keccak256(
        abi.encode(
            _recipient,
            _amount,
            _nonce
        )
    );}

    // 2. Convert it into an Ethereum Signed Message hash
    function getEthSignedMessageHash(
        bytes32 _messageHash
    ) public pure returns (bytes32) {
        return keccak256(
            abi.encodePacked(
                "\x19Ethereum Signed Message:\n32",
                _messageHash
            )
        );
    }

    // 3. Verify the signature
    function verifySignature(
        bytes32 _messageHash,
        uint8 _v,
        bytes32 _r,
        bytes32 _s
    ) public view returns (bool) {

        bytes32 ethSignedMessageHash =
            getEthSignedMessageHash(_messageHash);

        address signer = ecrecover(
            ethSignedMessageHash,
            _v,
            _r,
            _s
        );

        return signer == owner;
    }

    function recoverSigner(bytes32 _messageHash, uint8 _v, bytes32 _r, bytes32 _s) public pure returns (address) {

    bytes32 ethSignedMessageHash =
        getEthSignedMessageHash(_messageHash);

    return ecrecover(
        ethSignedMessageHash,
        _v,
        _r,
        _s
    ); } 

 function verifyAuthorization(
    address recipient,
    uint256 amount,
    uint256 nonce,
    uint8 v,
    bytes32 r,
    bytes32 s
) public view returns (bool) {

    // Build the exact message that was signed
    bytes32 hash = keccak256(
        abi.encode(
            recipient,
            amount,
            nonce
        )
    );

    // Convert to Ethereum signed-message hash
    bytes32 ethSignedMessageHash =
        getEthSignedMessageHash(hash);

    // Recover signer
    address signer = ecrecover(
        ethSignedMessageHash,
        v,
        r,
        s
    );

    // Check signer AND nonce
    return (
        signer == owner &&
        nonce == nonces[owner]
    ); }

function executeAuthorization(
    address recipient,
    uint256 amount,
    uint256 nonce,
    uint8 v,
    bytes32 r,
    bytes32 s
) external {

    require(
        verifyAuthorization(
            recipient,
            amount,
            nonce,
            v,
            r,
            s
        ),
        "Invalid authorization"
    );

    nonces[owner] += 1;

    emit AuthorizationExecuted(
        recipient,
        amount,
        nonce
    );}
}