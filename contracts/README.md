# Contracts

This contracts section found here aim to onchain represent the assets and some actions that can be performed based on the logic contained within the backend of the Cartesi application through the voucher API when internally invoked.

> [!IMPORTANT]
> To interact with this project snippet, it is necessary to install Foundry, a toolkit for Ethereum application development, follow the instructions provided [here](https://getfoundry.sh/). Additionally, it is necessary to have the "make" binary configured on your machine. Disclaimer: all actions described here were performed on an Ubuntu-based distribution.

## 1. General Architechture:


The general interaction architecture among the contracts presented here with other parts of the system features a layer of contracts representing assets/tokens, which will later serve as objects for system interaction. Additionally, within this layer of contracts, there is an implementation of the proxy pattern that allows the application contract to deploy other contracts, acting as a factory. The actions schematized from the frontend directly with Deroll's assets mostly involve calling the approve(address,uint256) function of the assets by the user to the portals of the CRF, i.e., [Cartesi Rollups Framework](https://docs.cartesi.io/cartesi-rollups/).
```mermaid
graph TD
    classDef core fill:#ffe95a,color:#000
    classDef master fill: #7AF8FA,color:#000
    classDef external fill:#85b4ff,color:#000

    ERC721Deroll:::core
    ERC1155Deroll:::core
    DeployerPlugin:::core
    Application:::external
    CRF[Cartesi Rollups Framework]:::master
    Frontend:::external
    
    Frontend --> CRF
    CRF --> Application

    Frontend --> DeployerPlugin
    Frontend --> ERC721Deroll
    Frontend --> ERC1155Deroll
    
    Application --> ERC721Deroll
    Application --> ERC1155Deroll
    Application --> DeployerPlugin
```

## 2. How the DeployerPlugin.sol works:

This plugin allows your DApp to act as a factory, creating new contracts based on their respective bytecodes. In the scope presented here, this function is invoked during the execution of a DApp voucher.

```mermaid
graph TD
    classDef core fill:#ffe95a,color:#000
    classDef external fill:#85b4ff,color:#000
    classDef master fill: #7AF8FA,color:#000

    Application:::master
    AnyContract:::core
    DeployerPlugin:::external

    Application -- deployAnyContract --> DeployerPlugin
    DeployerPlugin -- deploy --> AnyContract
```

## 3. Vouchers X Deroll Assets:

The Cartesi DApps deployed on the networks supported by this application can, through user interactions using vouchers, handle the most commonly used patterns of assets supported by the CRF portals, i.e., [Cartesi Rollups Framework](https://docs.cartesi.io/cartesi-rollups/).

### - Interacting w/ ERC721Deroll:

```mermaid
graph TD
    classDef core fill:#ffe95a,color:#000
    classDef external fill:#85b4ff,color:#000

    Anyone:::core
    ERC721Deroll:::external

    ERC721Deroll -- safeMint --> Anyone
    Anyone -- approve --> ERC721Deroll
    ERC721Deroll -- ... --> Anyone
```

### - Interacting w/ ERC1155Deroll:

```mermaid
graph TD
    classDef core fill:#ffe95a,color:#000
    classDef external fill:#85b4ff,color:#000

    Anyone:::core
    ERC1155Deroll:::external

    ERC1155Deroll -- mint --> Anyone
    Anyone -- approve --> ERC1155Deroll
    ERC1155Deroll -- ... --> Anyone
```

## 3. How to run:

To deploy these contracts on other networks not yet supported or on a localhost network, follow the commands below. For better interaction, enter the workspace within the "contracts" folder.

### Run the command below to generate the .env file and install the project dependencies contained in the `./.gitmodules` file:

```bash
make setup
```

### Run the command below to execute the tests:
```bash
make test
```

> [!IMPORTANT]
> Before running the command below, confirm that the `./.env` file contains all the necessary variables for deployment. For deploying on a local network, add the following values to the variables:

```env
RPC_URL="http://localhost:8545"
NETWORK="localhost"
PRIVATE_KEY="0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80" // You can use any private key from the local environment here.
TESTNET_BLOCKSCAN_API_KEY=""
```

### Run the command below to deploy the contracts:
```bash
make deploy
```

### Run the command below to check the new state of contracts after the voucher executions:
```bash
make vouchers
```
