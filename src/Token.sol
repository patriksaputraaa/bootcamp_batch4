// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//inherit Token from ERC20
contract Token is ERC20 {
    constructor() ERC20("MAKAN BERACUN GRATIS", "MBG") {
    }

    // mint = fungsi untuk mencetak uang
    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}
