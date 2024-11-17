// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract CounterScript is Script {
    MyToken public myToken;

    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        MyToken token = new MyToken{salt: bytes32("1596")}();
        vm.stopBroadcast();
        console.log("MyToken address:", address(token));
    }
}
