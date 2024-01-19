// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {DeployerPlugin} from "@contracts/proxy/DeployerPlugin.sol";
import {ERC20Deroll} from "@contracts/token/ERC20/ERC20Deroll.sol";
import {ERC721Deroll} from "@contracts/token/ERC721/ERC721Deroll.sol";
import {ERC1155Deroll} from "@contracts/token/ERC1155/ERC1155Deroll.sol";

contract DeployContracts is Script {
    function run() external {
        bytes32 _salt = bytes32(abi.encode(1596));
        vm.startBroadcast();
        ERC20Deroll erc20 = new ERC20Deroll{salt: _salt}();
        ERC721Deroll erc721 = new ERC721Deroll{salt: _salt}();
        ERC1155Deroll erc1155 = new ERC1155Deroll{salt: _salt}();
        DeployerPlugin proxy = new DeployerPlugin{salt: _salt}();
        vm.stopBroadcast();
        console.log(
            "ERC20Deroll address:",
            address(erc20),
            "at network:",
            block.chainid
        );
        console.log(
            "ERC721Deroll address:",
            address(erc721),
            "at network:",
            block.chainid
        );
        console.log(
            "DeployerPlugin address:",
            address(proxy),
            "at network:",
            block.chainid
        );
        console.log(
            "ERC1155Deroll address:",
            address(erc1155),
            "at network:",
            block.chainid
        );
    }
}
