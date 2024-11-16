<div align="center">
    <img src="https://github.com/Mugen-Builders/.github/assets/153661799/7ed08d4c-89f4-4bde-a635-0b332affbd5d" width="150" height="150">
</div>
<br>
<div align="center">
    <i>An Typescript example using Cartesi Cli, Nonodo and Deroll as High-Level Framework</i>
</div>
<div align="center">
<b>This example aims to demonstrate the lifecycle of a DApp using Deroll. In addition it serves as a template for integration with Avail.</b>
</div>
<br>
<div align="center">
    
  <a href="">[![Static Badge](https://img.shields.io/badge/cartesi-1.3.0-5bd1d7)](https://docs.cartesi.io/cartesi-rollups/)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/cartesi--cli-0.15.0-5bd1d7)](https://docs.cartesi.io/cartesi-rollups/1.3/quickstart/)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/nonodo-1.1.1-blue)](https://www.npmjs.com/package/nonodo)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/@deroll/app-0.7.0-yellow)](https://www.npmjs.com/package/@deroll/app)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/@deroll/router-0.5.0-yellow)](https://www.npmjs.com/package/@deroll/router)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/@deroll/wallet-0.8.0-yellow)](https://www.npmjs.com/package/@deroll/wallet)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/foundry-0.2.0-red)](https://book.getfoundry.sh/getting-started/installation)</a>
</div>

## Setup for Avail + Cartesi Machine binary:
As a reference for setting up your machine, [follow these steps](https://github.com/Mugen-Builders/cartesi-avail-tutorial?tab=readme-ov-file#prerequisites)

## Setup for standard interactions:

### This setup is divided into two parts:
1º - Install all dependencies:
   + Cartesi Cli:
   ```bash
   $ npm i -g @cartesi/cli
   ```

2º - Clone this repo using the code below:
   ```Bash
   git clone https://github.com/Mugen-Builders/learn-deroll.git \
   git checkout simple-dapp-onchain-interaction
   ```

## Running the test node:
```bash
$ nonodo
```

## Running the test node ( Brunodo ) with Avail integration ( Testnet ):
```bash
$ brunodo --avail-enabled -d --contracts-input-box-block 6850934 --rpc-url https://sepolia.drpc.org
```

## Running the test node ( Brunodo ) with Avail integration ( Locally ):
```bash
$ brunodo
```

## Build and run the application:
```bash
$ cartesi build
```

```bash
$ cartesi run --epoch-length 60
```

## Build and run the application with Cartesi Machine binary:
```bash
$ cartesi build
```

```bash
$ cartesi-machine --network \
 --flash-drive=label:root,filename:.cartesi/image.ext2 \
 --env=ROLLUP_HTTP_SERVER_URL=http://10.0.2.2:5004 -- /var/opt/cartesi-app/app
```

## Interactions:

Below are the instructions on how to interact with each section of the application, and some metadata of the performed operation. 

#### Send Tokens ERC20:

_User story number 2_

_Required past interactions: No past interactions._

##### Step 1:

###### Command:
```Bash
cast send 0x92C6bcA388E99d6B304f1Af3c3Cd749Ff0b591e2 "approve(address,uint256)" 0x9C21AEb2093C32DDbC53eEF24B873BDCd1aDa1DB 1000000000ether  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --rpc-url http://localhost:8545
```

###### Output Similar to:
```Shell
blockHash               0x0ad7ca64ebd3bae6de5146b46c2c31583760bea920afaa93c787f69b5c406729
blockNumber             104
contractAddress         
cumulativeGasUsed       46969
effectiveGasPrice       3000001085
gasUsed                 46969
logs                    [{"address":"0x92C6bcA388E99d6B304f1Af3c3Cd749Ff0b591e2","topics":["0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925","0x000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb92266","0x0000000000000000000000009c21aeb2093c32ddbc53eef24b873bdcd1ada1db"],"data":"0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000","blockHash":"0x0ad7ca64ebd3bae6de5146b46c2c31583760bea920afaa93c787f69b5c406729","blockNumber":"0x68","transactionHash":"0xc5b62bad0f91870b17ecf4b0380a9178b42ba04b0368ab4462878239ecc71c48","transactionIndex":"0x0","logIndex":"0x0","transactionLogIndex":"0x0","removed":false}]
logsBloom               0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000800000000000000000000080000000000000000000000000100000000000000000000000000000020000000000000000000000000000000000000000000000800000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000002000000000008000000000000010000000400000000000000000000000000000000000000000000000000000
root                    
status                  1
transactionHash         0xc5b62bad0f91870b17ecf4b0380a9178b42ba04b0368ab4462878239ecc71c48
transactionIndex        0
type                    2
```

##### Step 2:

###### Command:
```Bash
cartesi send erc20
```

###### Output Similar to:
```Shell
? Chain Foundry
? RPC URL http://127.0.0.1:8545
? Wallet Mnemonic
? Mnemonic test test test test test test test test test test test junk
? Account 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 8999.967782517274305856 ETH
? DApp address 0xab7528bb862fb57e8a2bcd567a2e929a0be56a5e
? Token address 0x92C6bcA388E99d6B304f1Af3c3Cd749Ff0b591e2
✔ Input sent: 0xc9f85574c90461c920972ba5e00de03b05477e022e50f72aebad898af6757a6c
```
  
> [!NOTE]
>  - Request Type: Advance State
>  - Contract Name: ERC20Portal
>  - Contract Function: "depositERC20Tokens(IERC20 token, address app, uint256 amount, bytes calldata execLayerData)"
>  - Contract Address: 0x9C21AEb2093C32DDbC53eEF24B873BDCd1aDa1DB
