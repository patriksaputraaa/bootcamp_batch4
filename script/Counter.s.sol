// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    // ini adalah file untuk deploy contract Counter
    // kita akan deploy contract ini ke jaringan arbitrum
    Counter public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast(); // untuk memulai broadcast transaksi ke jaringan arbitrum
        // kita akan deploy contract Counter ke jaringan arbitrum

        counter = new Counter();

        vm.stopBroadcast();
    }
}
