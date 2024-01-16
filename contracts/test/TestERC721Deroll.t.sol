//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {DeployerPlugin} from "@contracts/proxy/DeployerPlugin.sol";
import {ERC721Deroll} from "@contracts/token/ERC721/ERC721Deroll.sol";

contract TestERC721Deroll is Test {
    DeployerPlugin deployerPlugin;

    address guest = address(1);
    address application = address(2);

    function setUp() public {
        deployerPlugin = (new DeployerPlugin){salt: bytes32(abi.encode(1596))}();
    }

    function testInteractWithERC721DerollFromApplication() public {
        ERC721Deroll asset = deployerPlugin.deployERC721Deroll(application);
        vm.prank(application);
        asset.safeMint(guest, "QmXqngKXVbY6qEhbTdENaSARNwHSnRFMQhBC5aycNW81S8");
    }

    function testInteractWithERC721DerollFromGuest() public {
        ERC721Deroll asset = deployerPlugin.deployERC721Deroll(application);
        vm.prank(guest);
        vm.expectRevert();
        asset.safeMint(guest, "QmXqngKXVbY6qEhbTdENaSARNwHSnRFMQhBC5aycNW81S8");
    }
}