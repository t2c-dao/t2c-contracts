// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "./ICare.sol";

contract Exchange {
    address public owner;

    event TokenTransferred(address sender, address);

    ICare token;

    constructor(address _tokenAddress) {
        token = ICare(_tokenAddress);
    }

    // mapping element id to its price
    mapping(uint => uint) prices;

    // mapping element to its name
    mapping(uint => string) commodity;

    function callToken(
        address recepient,
        uint256 commodityId
    ) external returns (bool) {
        require(
            token.category1(msg.sender),
            "Not ELigible: Not a category 1 Company"
        );

        token.distributeToken(msg.sender, recepient, prices[commodityId]);
        emit TokenTransferred(msg.sender, recepient);
        return true;
    }

    function reimburseTokens(
        address recepient,
        uint256 _amount
    ) external payable returns (bool) {
        require(token.isUser(msg.sender), "Not a Valid user!!");

        token.transferFrom(msg.sender, recepient, _amount);
        emit TokenTransferred(msg.sender, recepient);
        return true;
    }
}
