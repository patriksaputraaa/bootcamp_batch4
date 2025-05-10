// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    address public alice = makeAddr("Alice"); // membuat akun Alice

    function setUp() public {
        // ini akan dijalankan setiap kali ingin test
        counter = new Counter();
        counter.setNumber(0);
    }

    //penamaan fungsi test harus test_
    function test_setPrice() public {

        counter.setPrice(100);
        
        vm.prank(alice); // login sebagai alice
        vm.expectRevert("Only the owner can set the price"); // ekspetasi error, disamakan dengan return error, 
        // mengecek apakah syntax setelahnya memberikan error yang diekspetasikan
        counter.setPrice(100);

        vm.prank(address(this)); // prank sebagai owner
        counter.setPrice(100);
        assertEq(counter.price(), 100);
        console.log("Price set to 100");
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }
}
