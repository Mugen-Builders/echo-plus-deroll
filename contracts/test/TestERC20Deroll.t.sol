//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {DeployerPlugin} from "@contracts/proxy/DeployerPlugin.sol";
import {ERC20Deroll} from "@contracts/token/ERC20/ERC20Deroll.sol";
import {ERC721Deroll} from "@contracts/token/ERC721/ERC721Deroll.sol";
import {ERC1155Deroll} from "@contracts/token/ERC1155/ERC1155Deroll.sol";

contract TestERC20Deroll is Test {
    DeployerPlugin deployerPlugin;

    address guest = address(1);
    address application = address(2);

    function setUp() public {
        deployerPlugin = (new DeployerPlugin){salt: bytes32(abi.encode(1596))}();
    }

    function testInteractWithERC20DerollFromApplication() public {
        ERC20Deroll asset = deployerPlugin.deployERC20Deroll(application);
        vm.prank(application);
        asset.mint(guest, 1000);
        assertTrue(asset.balanceOf(guest) == 1000);
    }

    function testInteractWithERC20DerollFromGuest() public {
        ERC20Deroll asset = deployerPlugin.deployERC20Deroll(application);
        vm.prank(guest);
        vm.expectRevert();
        asset.mint(guest, 1000);
    }
}