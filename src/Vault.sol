// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

//inherit Token from ERC20
contract Vault is ERC20 {

    address public usdc;

    constructor(address _usdc) ERC20("Vault", "VAULT") {
        usdc = _usdc;
    }
    // vault tidak ada fungsi mint

    function deposit(uint256 amount) public {
        //shares = amount / totalAsset * totalShares
        uint256 totalAsset = IERC20(usdc).balanceOf(address(this)); //total aset dari vault
        uint256 totalShares = totalSupply();

        uint256 shares = 0;
        if (totalShares == 0){
            shares = amount; // jika totalShares masih 0 maka shares = amount
        }else{
            shares = amount * totalShares / totalAsset; //jika sudah ada shares maka shares = amount / totalAsset * totalShares
        }
        // mint shares to user
        _mint(msg.sender, shares);

        // USDC dari msg.sender diambil/dikirim ke dalam vault
        IERC20(usdc).transferFrom(msg.sender, address(this), amount); // mengambil usdc user ke vault
    }

    function withdraw(uint256 shares) public {
        //amount = shares * totalAsset / totalShares
        uint256 totalAsset = IERC20(usdc).balanceOf(address(this));
        uint256 totalShares = totalSupply();
        
        uint256 amount = shares * totalAsset / totalShares;
        
        // burn shares from user
        _burn(msg.sender, shares);
        // USDC dari vault dikirim ke msg.sender
        IERC20(usdc).transfer(msg.sender, amount);
    }

    function distributeYield(uint256 amount) public {
        IERC20(usdc).transferFrom(msg.sender, address(this), amount);
        // manajer mendistribusikan yield
    }
}
