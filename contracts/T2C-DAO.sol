// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the IPFS library
import "./IPFS.sol";

contract T2C {
    // Variables
    uint public totalShares;
    uint public totalFunds;
    mapping(address => uint) public shares;
    mapping(address => bool) public shareholders;

    // Events
    event Deposit(address indexed sender, uint amount);
    event Withdraw(address indexed recipient, uint amount);
    event Transfer(
        address indexed sender,
        address indexed recipient,
        uint amount
    );
    event NewShareholder(address indexed shareholder);
    event RemoveShareholder(address indexed shareholder);
    event ProposalCreated(
        address indexed proposer,
        bytes32 indexed proposalHash
    );

    // IPFS library instance
    IPFS ipfs;

    string gold = "bafkreidsttl5qv22ry7zm3cpu6oe4rulturpndqwwy7yfrn7yc2vaszzrq";
    string silver =
        "bafkreibont4z4rfc64ihrnsh3druurgcyh3kawn66rmj3d7llynyzhnbvu";
    string bronze =
        "bafkreidmcn6egi2bpkcees4jcun4rd62cy3m735b4qyqmsgupezbcyi4ha";

    // Constructor
    constructor(IPFS _ipfs) {
        ipfs = _ipfs;
    }

    // Functions
    function deposit() external payable {
        totalFunds += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint amount) external {
        require(amount <= totalFunds, "Insufficient funds");
        require(
            shares[msg.sender] == 0,
            "Cannot withdraw while holding shares"
        );

        totalFunds -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    function transfer(address recipient, uint amount) external {
        require(shares[msg.sender] >= amount, "Insufficient shares");

        shares[msg.sender] -= amount;
        shares[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
    }

    function issueShares(address shareholder, uint amount) external {
        require(!shareholders[shareholder], "Shareholder already exists");

        shares[shareholder] += amount;
        totalShares += amount;
        shareholders[shareholder] = true;
        emit NewShareholder(shareholder);
    }

    function removeShares(address shareholder, uint amount) external {
        require(shareholders[shareholder], "Shareholder does not exist");
        require(shares[shareholder] >= amount, "Insufficient shares");

        shares[shareholder] -= amount;
        totalShares -= amount;
        if (shares[shareholder] == 0) {
            shareholders[shareholder] = false;
            emit RemoveShareholder(shareholder);
        }
    }

    function createProposal(string calldata proposalData) external {
        // Hash the proposal data and upload to IPFS
        bytes32 proposalHash = ipfs.addProposal(proposalData);

        // Emit an event with the proposal hash
        emit ProposalCreated(msg.sender, proposalHash);
    }
}
