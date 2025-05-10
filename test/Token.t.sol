// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol"; // jangan lupa import class Token

contract TokenTest is Test {
    Token public token;

    address public alice = makeAddr("Alice");
    address public bob = makeAddr("Bob");

    function setUp() public {
        token = new Token(); // deploy token
    }

    function test_Mint() public {
        token.mint(alice, 1337);
        assertEq(token.balanceOf(alice), 1337);
        console.log("Balance of alice", token.balanceOf(alice));

        token.mint(bob, 1337);
        assertEq(token.balanceOf(bob), 1337);
        console.log("Balance of bob", token.balanceOf(bob));
        
        token.mint(address(this), 1337);
        assertEq(token.balanceOf(address(this)), 1337); // cek apakah balance of address(this) sama dengan 1337
        console.log("Balance of this", token.balanceOf(address(this)));
    }
}
