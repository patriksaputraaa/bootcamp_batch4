// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Lending} from "../src/Lending.sol"; // jangan lupa import class
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LendingTest is Test {
    Lending public lending;

    address weth = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1; //dapat dari mana
    address usdc = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831;

    function setUp() public {
        vm.createSelectFork("https://arb-mainnet.g.alchemy.com/v2/QFJp2k3zSgleW94onzQkCpOedtjU_ZrZ", 335106328);
        lending = new Lending();
    }

    function test_supplyAndBorrow() public {
        deal(weth, address(this), 1e18);// 1 ETH ada 18 decimals = 100000000000000000000 wei
        // deal(usdc, address(this), 1e6); // 1 USDC ada 6 decimals

        IERC20(weth).approve(address(lending), 1e18);

        lending.supplyAndBorrow(1e18, 100e6);

        assertEq(IERC20(usdc).balanceOf(address(this)), 100e6); // kalau saya pinjam 100 USDC, saya punya 100 USDC di wallet saya
    }
}
