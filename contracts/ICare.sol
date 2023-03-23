// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface ICare {
    function owner() external view returns (address);

    function category1(address _account) external view returns (bool);

    function isUser(address _account) external view returns (bool);

    function category2(address _account) external view returns (bool);

    function price() external view returns (uint);

    function minimumPurchaseLimit() external view returns (uint);

    function securityAmount() external view returns (uint);

    function registerCategory1() external payable;

    function registerCategory2() external;

    function registerUser() external;

    function checkBalance(address _account) external view returns (uint);

    function mint() external payable;

    function changeName(address _owner) external;

    function distributeToken(
        address sender,
        address recepient,
        uint256 _amount
    ) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    function allowance(
        address owner,
        address spender
    ) external returns (uint256);
}
