// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CARE is ERC20 {
    // -> CARE should not be publicly tradeable

    event ownershipChanged(address oldOwner, address newOwner);
    event nameChanged(string oldName, string newName);
    event tokensMinted(address recepient, uint256 amount);

    address public owner;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC20(_name, _symbol) {
        owner = msg.sender;
    }

    mapping(address => bool) public category1;
    mapping(address => bool) public isUser;
    mapping(address => bool) public category2;
    mapping(address => uint256) public tokensDistributed;

    uint256 public price = 0.0000083 ether;
    uint256 public minimumPurchaseLimit = 1000;
    uint256 public securityAmount = 0.5 ether;

    modifier onlyOwner() {
        require(msg.sender == owner, "UNAUTHORIZED ACCESS: Not the owner");
        _;
    }

    // register as category1

    function registerCategory1() external payable {
        require(
            msg.value >= securityAmount,
            "ERROR: Minimum security amount not provided"
        );
        category1[msg.sender] = true;
    }

    // register as category2

    function registerCategory2() external {
        require(
            category1[msg.sender] == false,
            "Oops!, Already registered as Category1"
        );
        require(
            isUser[msg.sender] == false,
            "Oops!, Already registered as User"
        );
        category2[msg.sender] = true;
    }

    // register as user

    function registerUser() external {
        require(
            category1[msg.sender] == false,
            "Oops!, Already registered as Category1"
        );
        require(
            category2[msg.sender] == false,
            "Oops!, Already registered as Category2"
        );

        isUser[msg.sender] = true;
    }

    // buy tokens

    function mint() external payable {
        require(
            minimumPurchaseLimit < msg.value / price,
            "FAILED: Minimum purchase limit not satisfied"
        );
        require(
            category1[msg.sender] == true,
            "Organisation not registered as category 1"
        );

        _mint(msg.sender, msg.value / price);

        emit tokensMinted(msg.sender, msg.value / price);
    }

    // change owner
    function changeName(address _owner) public onlyOwner {
        owner = _owner;

        emit ownershipChanged(msg.sender, owner);
    }

    // distribution

    function distributeToken(
        address sender,
        address recepient,
        uint256 _amount
    ) external returns (bool) {
        require(category1[sender] == true, "Not a category1 company");
        // require(msg.sender == owner, "ERROR: Only owner contract can distribute the tokens");
        require(balanceOf(sender) > _amount, "ERROR: Vendor is out of balance");

        transferFrom(sender, recepient, _amount);

        tokensDistributed[sender] += _amount;

        return true;
    }

    // make not tradeable

    function transfer(
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        require(msg.sender == owner, "ERROR: Not the Owner");
        _transfer(owner, to, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        // address spender = _msgSender();
        // _spendAllowance(from, spender, amount);
        require(msg.sender == owner, "ERROR: Owner privileged access only");
        _transfer(from, to, amount);
        return true;
    }
}
