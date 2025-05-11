// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Reksadana} from "../src/Reksadana.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ReksadanaTest is Test {
    Reksadana public reksadana;

    address weth = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
    address usdc = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831;
    address wbtc = 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f;

    function setUp() public {
        vm.createSelectFork("https://arb-mainnet.g.alchemy.com/v2/QFJp2k3zSgleW94onzQkCpOedtjU_ZrZ", 335106328);
        reksadana = new Reksadana();
    }

    function test_totalAsset() public {
        deal(wbtc, address(reksadana), 1e8); // memasukkan 1 wbtc ke dalam reksadana
        deal(weth, address(reksadana), 10e18); // memasukkan 1 weth ke dalam reksadana

        console.log("Total Asset", reksadana.totalAsset());
    }

    function test_deposit() public {
        deal(usdc, address(this), 1000e6);
        IERC20(usdc).approve(address(reksadana), 1000e6);
        reksadana.deposit(1000e6);

        console.log("total asset", reksadana.totalAsset());
        console.log("user shares", IERC20(address(reksadana)).balanceOf(address(this)));
    }

    function test_withdraw() public {
        deal(usdc, address(this), 1000e6);
        IERC20(usdc).approve(address(reksadana), 1000e6);
        reksadana.deposit(1000e6);

        uint256 shares = IERC20(address(reksadana)).balanceOf(address(this));
        reksadana.withdraw(shares);

        console.log("total asset", reksadana.totalAsset());
        console.log("user shares", IERC20(address(reksadana)).balanceOf(address(this)));
        assertEq(IERC20(address(reksadana)).balanceOf(address(this)), 0);
    }

    function test_error_withdraw() public {
        deal(usdc, address(this), 1000e6);
        IERC20(usdc).approve(address(reksadana), 1000e6);
        reksadana.deposit(1000e6);
        
        // withdraw 0 shares
        vm.expectRevert(Reksadana.ZeroAmount.selector);
        reksadana.withdraw(0);

        // withdraw lebih dari jumlah shares yang dimiliki
        uint256 shares = IERC20(address(reksadana)).balanceOf(address(this));
        vm.expectRevert(Reksadana.InsufficientShares.selector);
        reksadana.withdraw(shares + 1);
    }
}