//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {ERC1155Deroll} from "@contracts/token/ERC1155/ERC1155Deroll.sol";

contract TestERC1155Deroll is Test {
    ERC1155Deroll erc1155;

    address guest = address(1);
    address application = address(2);

    function setUp() public {
        erc1155 = new ERC1155Deroll{salt: bytes32(abi.encode(1596))}();
    }

    function testMintERC1155Deroll() public {
        vm.prank(application);
        erc1155.mint(guest, 1, 100, "");
        assertTrue(erc1155.balanceOf(guest, 1) == 100);
    }
}
