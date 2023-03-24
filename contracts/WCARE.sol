// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "./ICare.sol";

contract WCARE is ERC20 {
    ICare public token;
    address public admin;

    constructor(address _tokenAddress) ERC20("Wrapped 5ire Token", "W5IRE") {
        token = ICare(_tokenAddress);
        admin = msg.sender;
    }

    uint256 public deductionPercentage = 12;

    function wrap(uint256 _amount) external {
        uint256 allowance = token.allowance(msg.sender, address(this));
        require(allowance >= _amount, "Allowance not enough");

        _amount = _amount - (_amount * deductionPercentage);

        token.transferFrom(msg.sender, address(this), _amount);
        _mint(msg.sender, _amount);
    }

    function unwrap(uint256 _amount) external payable {
        require(balanceOf(msg.sender) >= _amount, "Not enough W5IRE balance");

        // token.transfer(msg.sender, _amount);
        (bool sent, ) = (msg.sender).call{value: msg.value}("");
        require(sent, "Token unwrapping failed!!");
        _burn(msg.sender, _amount);
    }

    function transferAdmin(address _newAdmin) external {
        require(msg.sender == admin, "Only admin can transfer ownership");
        admin = _newAdmin;
    }
}
