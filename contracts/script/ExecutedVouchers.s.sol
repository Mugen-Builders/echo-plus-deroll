// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {DeployerPlugin} from "@contracts/proxy/DeployerPlugin.sol";
// import {ERC20Deroll} from "@contracts/token/ERC20/ERC20Deroll.sol";
import {ERC721Deroll} from "@contracts/token/ERC721/ERC721Deroll.sol";
import {ERC1155Deroll} from "@contracts/token/ERC1155/ERC1155Deroll.sol";

contract ExecutedVouchers is Script {
    function run() external {
        vm.startBroadcast();
        // ERC20Deroll erc20 = ERC20Deroll(0xBE9592fD0a56F2aD2090C2266D33D9DAd9C5Cf09);
        ERC721Deroll erc721 = ERC721Deroll(0xF320e7a3416Ee6B4DEe29333451b17534833F9cC);
        ERC1155Deroll erc1155 = ERC1155Deroll(0x4c4d35E8bf193183c1E5D66397A475c3c78C4F9D);
        DeployerPlugin proxy = DeployerPlugin(payable(0x87B6f9486B4474947884F1374f008a5745605d2B));
        vm.stopBroadcast();
        // console.log(
        //     "ERC20Deroll balanceOf:",
        //     msg.sender,
        //     "is",
        //     erc20.balanceOf(msg.sender)
        // );
        console.log(
            "ERC721Deroll balanceOf:",
            msg.sender,
            "is",
            erc721.balanceOf(msg.sender)
        );
        console.log(
            "ERC1155Deroll balanceOf ( tokenId: 1 ):",
            msg.sender,
            "is",
            erc1155.balanceOf(msg.sender, 1)
        );
        console.log(
            "Deployer Plugin, number of deploys:",
            proxy.deploys()
        );
    }
}
