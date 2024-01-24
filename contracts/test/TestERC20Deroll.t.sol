//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {ERC20Deroll} from "@contracts/token/ERC20/ERC20Deroll.sol";

contract TestERC20Deroll is Test {
    ERC20Deroll erc20;

    address guest = address(1);
    address application = address(2);

    function setUp() public {
        erc20 = new ERC20Deroll{salt: bytes32(abi.encode(1596))}();
    }

    function testMintWithERC20Deroll() public {
        vm.prank(application);
        erc20.mint(guest, 100);
        assertTrue(erc20.balanceOf(guest) == 100);
    }
}
