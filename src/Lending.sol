// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Aave pool: https://www.arbiscan.io/address/0x794a61358d6845594f94dc1db02a252b5b4814ad#writeProxyContract

// WETH: https://arbiscan.io/token/0x82af49447d8a07e3bd95bd0d56f35241523fbab1

// USDC: 
// https://arbiscan.io/token/0xaf88d065e77c8cc2239327c5edb3a432268e5831

interface IAave {
    function supply(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
    function borrow(address asset, uint256 amount, uint256 interestRateMode, uint16 referralCode, address onBehalfOf) external;
}

contract Lending {
    address weth = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1; //dapat dari mana
    address usdc = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831;
    address aave = 0x794a61358D6845594F94dc1DB02A252b5b4814aD;

    function supplyAndBorrow(uint256 supplyAmount, uint256 borrowAmount) external {
        //deposit
        IERC20(weth).transferFrom(msg.sender, address(this), supplyAmount);

        //supply ke AAVE pool
        IERC20(weth).approve(address(aave), supplyAmount); // kalau supply harus approve
        IAave(aave).supply(weth, supplyAmount, address(this), 0);

        //borrow ke aave
        IAave(aave).borrow(usdc, borrowAmount, 2, 0, address(this));

        //withdraw atau tf usdc ke user
        IERC20(usdc).transfer(msg.sender, borrowAmount);
        console.log("Balance of usdc", IERC20(usdc).balanceOf(msg.sender));
    }
}