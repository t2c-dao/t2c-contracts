// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

pragma solidity ^0.8.0;

interface IPFS {
    function addProposal(
        string calldata proposalData
    ) external returns (bytes32);

    function getProposal(
        bytes32 proposalHash
    ) external view returns (string memory);
}
