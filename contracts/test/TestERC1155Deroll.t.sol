//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {DeployerPlugin} from "@contracts/proxy/DeployerPlugin.sol";
import {ERC1155Deroll} from "@contracts/token/ERC1155/ERC1155Deroll.sol";

contract TestERC1155Deroll is Test {
    DeployerPlugin deployerPlugin;

    address guest = address(1);
    address application = address(2);

    function setUp() public {
        deployerPlugin = (new DeployerPlugin){salt: bytes32(abi.encode(1596))}();
    }

    function testInteractWithERC1155DerollFromApplication() public {
        ERC1155Deroll asset = deployerPlugin.deployERC1155Deroll(application);
        vm.prank(application);
        asset.mint(guest, 0, 100, bytes(""));
        assertTrue(asset.balanceOf(guest, 0) == 100);
    }

    function testInteractWithERC1155DerollFromGuest() public {
        ERC1155Deroll asset = deployerPlugin.deployERC1155Deroll(application);
        vm.prank(guest);
        vm.expectRevert();
        asset.mint(guest, 0, 100, bytes(""));
    }
}