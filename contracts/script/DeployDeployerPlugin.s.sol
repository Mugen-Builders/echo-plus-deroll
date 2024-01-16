// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {DeployerPlugin} from "@contracts/proxy/DeployerPlugin.sol";

contract DeployDeployerPlugin is Script {
    function run() external {
        vm.startBroadcast();
        DeployerPlugin proxy = new DeployerPlugin();
        vm.stopBroadcast();
        console.log("Proxy deployer plugin address:", address(proxy), "at network:", block.chainid); 
    }
}