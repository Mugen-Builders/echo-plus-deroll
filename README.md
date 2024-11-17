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
    
  <a href="">[![Static Badge](https://img.shields.io/badge/cartesi-2.0.0-5bd1d7)](https://docs.cartesi.io/cartesi-rollups/)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/cartesi--cli-0.15.0-5bd1d7)](https://docs.cartesi.io/cartesi-rollups/1.3/quickstart/)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/brunodo--2.15.0-beta-blue)](https://www.npmjs.com/package/nonodo)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/@deroll/app--2.0.0-alpha.0-yellow)](https://www.npmjs.com/package/@deroll/app)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/@deroll/router--2.0.0-alpha.0-yellow)](https://www.npmjs.com/package/@deroll/router)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/@deroll/wallet--2.0.0-alpha.0-yellow)](https://www.npmjs.com/package/@deroll/wallet)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/foundry-0.2.0-red)](https://book.getfoundry.sh/getting-started/installation)</a>
</div>

## Setup for Avail + Cartesi Machine interactions:
As a reference for setting up your machine, [follow these steps](https://github.com/Mugen-Builders/cartesi-avail-tutorial?tab=readme-ov-file#prerequisites)

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

3º Running the frontend:
  ```bash
  cd frontent \
  yarn \
  yarn codegen \
  yarn dev --port 3000
  ```

## Running the test node ( Brunodo ) with Avail integration ( Locally ):
```bash
$ brunodo
```

> [!NOTE]
>  - Running test node pointing to Sepolia testnet
>  brunodo --avail-enabled -d --contracts-input-box-block 6850934 --rpc-url https://sepolia.drpc.org --epoch-blocks 0 --contracts-application-address <dapp-address>

## Deploy a ERC20 Token:

```bash
cd contracts
make setup
make token
```

> [!Warning]
> Before running the command below on the testnet, make sure to properly update the environment variables (```contracts/.env```).

## Build and run the application with Cartesi Machine binary:
```bash
$ cartesi build
```

```bash
$ cartesi-machine --network --flash-drive=label:root,filename:.cartesi/image.ext2 \
--volume=.:/mnt --env=ROLLUP_HTTP_SERVER_URL=http://10.0.2.2:5004 \
--workdir=/opt/cartesi/dapp -- node index
```

## Interactions:

Below are the instructions on how to interact with each section of the application, and some metadata of the performed operation. 

#### Send Tokens ERC20:

_Required past interactions: Deploy the ERC20 token._

> [!Note]
> Use 0x59468ea4Dd4e55F9250FBCAa15281625f4333F27 as the token address to interact via frontend.

###### Output Similar to:

> [!NOTE]
>  - Request Type: Advance State
>  - Contract Name: ERC20Portal
>  - Contract Function: "depositERC20Tokens(IERC20 token, address appContract, uint256 value, bytes calldata execLayerData)"
>  - Contract Address: 0xCF3A2BA57D28e7A4B9E2c5E5bcFff65A7aef6E98

#### Play:

_Required past interactions: Send Tokens ERC20._

##### Step 1:

###### Command:
```bash
```

###### Output:
```bash
```

##### Step 2:

###### Command:
```bash
```

###### Output:
```bash
```

> [!NOTE]
>  - Request Type: Advance State
>  - Contract Name: TestToken
>  - Contract Function: "mint(address,uint256)"
>  - Contract Address: 0x59468ea4Dd4e55F9250FBCAa15281625f4333F27