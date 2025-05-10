// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    // ini adalah databasenya, langsung di sini
    uint256 public number;
    uint256 public price;

    address public owner;

    constructor() {
        owner = msg.sender;
    }
    
    function setPrice(uint256 newPrice) public {
        require(msg.sender == owner, "Only the owner can set the price");
        // tidak bisa set price kalau bukan owner
        price = newPrice;
    }
    
    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
