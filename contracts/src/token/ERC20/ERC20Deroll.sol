// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract ERC20Deroll is ERC20, ERC20Burnable, ERC20Permit {
    constructor() ERC20("ERC20Deroll", "ERC20D") ERC20Permit("ERC20Deroll") {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}
