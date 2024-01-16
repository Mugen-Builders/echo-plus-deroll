// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20Deroll} from "@contracts/token/ERC20/ERC20Deroll.sol";
import {ERC721Deroll} from "@contracts/token/ERC721/ERC721Deroll.sol";
import {ERC1155Deroll} from "@contracts/token/ERC1155/ERC1155Deroll.sol";

contract DeployerPlugin {
    event DeployContract(address sender, address asset);
    error DeployFailed(address sender, address asset);

    receive() external payable {}

    function deployAnyContract(
        bytes memory _bytecode
    ) external payable returns (address addr) {
        assembly {
            // create(v, p, n)
            // v = amount of ETH to send
            // p = pointer in memory to start of _bytecode
            //36 n = size of _bytecode
            addr := create(callvalue(), add(_bytecode, 0x20), mload(_bytecode))
        }
        if (addr == address(0)) revert DeployFailed(msg.sender, addr);
        emit DeployContract(msg.sender, addr);
        return addr;
    }

    function deployERC20Deroll(
        address application
    ) external payable returns (ERC20Deroll) {
        ERC20Deroll asset = new ERC20Deroll(application);
        if (address(asset) == address(0))
            revert DeployFailed(msg.sender, address(asset));
        emit DeployContract(msg.sender, address(asset));
        return asset;
    }

    function deployERC721Deroll(
        address application
    ) external payable returns (ERC721Deroll) {
        ERC721Deroll asset = new ERC721Deroll(application);
        if (address(asset) == address(0))
            revert DeployFailed(msg.sender, address(asset));
        emit DeployContract(msg.sender, address(asset));
        return asset;
    }

    function deployERC1155Deroll(
        address application
    ) external payable returns (ERC1155Deroll) {
        ERC1155Deroll asset = new ERC1155Deroll(application);
        if (address(asset) == address(0))
            revert DeployFailed(msg.sender, address(asset));
        emit DeployContract(msg.sender, address(asset));
        return asset;
    }
}
