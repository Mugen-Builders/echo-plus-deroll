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
    
  <a href="">[![Static Badge](https://img.shields.io/badge/cartesi-1.4.0-5bd1d7)](https://docs.cartesi.io/cartesi-rollups/)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/cartesi--cli-0.15.0-5bd1d7)](https://docs.cartesi.io/cartesi-rollups/1.3/quickstart/)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/brunodo--2.15.0-beta-blue)](https://www.npmjs.com/package/nonodo)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/@deroll/app-1.0.0-yellow)](https://www.npmjs.com/package/@deroll/app)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/@deroll/router-1.0.0-yellow)](https://www.npmjs.com/package/@deroll/router)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/@deroll/wallet-1.0.0-yellow)](https://www.npmjs.com/package/@deroll/wallet)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/foundry-0.2.0-red)](https://book.getfoundry.sh/getting-started/installation)</a>
</div>

## Setup for base layer interactions:

### This setup is divided into three parts:

1º Install Cartesi cli:
   + Cartesi Cli:
   ```bash
   $ npm i -g @cartesi/cli
   ```

2º Clone this repo using the code below:
   ```Bash
   git clone https://github.com/Mugen-Builders/learn-deroll.git \
   cd learn-deroll \
   git checkout simple-dapp-onchain-interaction
   ```

## Build and run the application:
```bash
$ cartesi build
```

```bash
$ cartesi run --epoch-length 10
```

## Deploy a ERC20 Token:

```bash
cd contracts
make setup
make token
```

## Interactions:

Below are the instructions on how to interact with each section of the application, and some metadata of the performed operation. 

#### Play:

_Required past steps: Send Tokens ERC20 and Deploy a ERC20 Token._

##### Step 1:

###### Command:
```bash
cast calldata "play(uint256)" 5
```

###### Output:
```bash
0x6898f82b0000000000000000000000000000000000000000000000000000000000000005
```

##### Step 2:

###### Command:
```bash
cartesi send generic --chain-id=31337 --rpc-url=http://localhost:8545 --dapp=0xab7528bb862fB57E8A2BCd567a2e929a0Be56a5e --input=0x6898f82b0000000000000000000000000000000000000000000000000000000000000005 --mnemonic-passphrase="test test test test test test test test test test test junk" --mnemonic-index=0
```

###### Output:
```bash
✔ Input sent: 0x130efbd39718c3933c0100127d2c73ac907d25e081e22d2888797c879899ff38
```

> [!NOTE]
>  - Request Type: Advance State
>  - Contract Name: InputBox
>  - Contract Function: "addInput(address app, bytes calldata payload)"
>  - Contract Address: 0x59b22D57D4f067708AB0c00552767405926dc768

#### Execute voucher

_Required past steps: Play._

> [!WARNING]
> - To view the tokens in your wallet, you need to add the deployed ERC20 contract address: 0xF0F73414cC05d6Ace602B3ae435Ca9ACF9e24bF2.

Access the [explorer](http://localhost:8080/explorer) to execute the voucher.

> [!NOTE]
>  - Request Type: Voucher Execution
>  - Contract Name: TestToken
>  - Contract Function: "mint(address,uint256)"
>  - Contract Address: 0xF0F73414cC05d6Ace602B3ae435Ca9ACF9e24bF2
