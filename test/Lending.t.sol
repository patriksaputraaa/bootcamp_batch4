// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Lending} from "../src/Lending.sol"; // jangan lupa import class

contract LendingTest is Test {
    Lending public lending;

    address weth = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1; //dapat dari mana
    address usdc = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831;
    address aave = 0x794a61358D6845594F94dc1DB02A252b5b4814aD;

    function setUp() public {
        vm.createSelectFork("https://arb-mainnet.g.alchemy.com/v2/QFJp2k3zSgleW94onzQkCpOedtjU_ZrZ");
        lending = new Lending();
    }
}
