//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {DeployerPlugin} from "@contracts/proxy/DeployerPlugin.sol";
import {ERC20Deroll} from "@contracts/token/ERC20/ERC20Deroll.sol";
import {ERC721Deroll} from "@contracts/token/ERC721/ERC721Deroll.sol";
import {ERC1155Deroll} from "@contracts/token/ERC1155/ERC1155Deroll.sol";

contract TestDeployerPlugin is Test {
    DeployerPlugin deployerPlugin;

    address guest = address(1);
    address application = address(2);

    function setUp() public {
        deployerPlugin = (new DeployerPlugin){salt: bytes32(abi.encode(1596))}();
    }

    function testDeployAnyContract() public {
        bytes memory bytecode = type(ERC20Deroll).creationCode;
        vm.prank(application);
        address addr = deployerPlugin.deployAnyContract(abi.encodePacked(bytecode, abi.encode(application)));
        assertTrue(addr != address(0));
    }

    function testDeployERC20Deroll() public {
        ERC20Deroll asset = deployerPlugin.deployERC20Deroll(application);
        assertTrue(address(asset) != address(0));
    }

    function testDeployWithERC721Deroll() public {
        ERC721Deroll asset = deployerPlugin.deployERC721Deroll(application);
        assertTrue(address(asset) != address(0));
    }

    function testDeployWithERC1155Deroll() public {
        ERC1155Deroll asset = deployerPlugin.deployERC1155Deroll(application);
        assertTrue(address(asset) != address(0));
    }
}