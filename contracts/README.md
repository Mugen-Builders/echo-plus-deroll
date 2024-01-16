# Contracts

This contracts section found here aim to onchain represent the assets and some actions that can be performed based on the logic contained within the backend of the Cartesi application through the voucher API when internally invoked.

> [!IMPORTANT]
> To interact with this project snippet, it is necessary to install Foundry, a toolkit for Ethereum application development. Follow the instructions provided [here](https://getfoundry.sh/)

## 1. General Architechture:

```mermaid
graph TD
    classDef core fill:#ffe95a,color:#000
    classDef master fill: #7AF8FA,color:#000
    classDef external fill:#85b4ff,color:#000

    ERC20Deroll:::core
    ERC721Deroll:::core
    ERC1155Deroll:::core
    DeployerPlugin:::core
    Application:::external
    Backend:::master

    Backend -- voucher --> Application

    Application -- action --> ERC20Deroll
    Application -- action --> ERC721Deroll
    Application -- action --> ERC1155Deroll
    Application -- action --> DeployerPlugin
```

## 2. How the DeployerPlugin works:

```mermaid
graph TD
    classDef core fill:#ffe95a,color:#000
    classDef external fill:#85b4ff,color:#000

    AnyContract:::core
    ERC20Deroll:::core
    ERC721Deroll:::core
    ERC1155Deroll:::core
    DeployerPlugin:::external


    DeployerPlugin -- deploy --> ERC20Deroll
    DeployerPlugin -- deploy --> ERC721Deroll
    DeployerPlugin -- deploy --> ERC1155Deroll
    DeployerPlugin -- deploy --> AnyContract
```

### - Interacting w/ ERC20Deroll: 

```mermaid
graph TD
    classDef core fill:#ffe95a,color:#000
    classDef external fill:#85b4ff,color:#000

    Anyone:::core
    ERC20Deroll:::external

    ERC20Deroll -- mint --> Anyone
    ERC20Deroll -- transfer --> Anyone
    ERC20Deroll -- ... --> Anyone
```

### - Interacting w/ ERC721Deroll:

```mermaid
graph TD
    classDef core fill:#ffe95a,color:#000
    classDef external fill:#85b4ff,color:#000

    Anyone:::core
    ERC721Deroll:::external

    ERC721Deroll -- safeMint --> Anyone
    ERC721Deroll -- transfer --> Anyone
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
    ERC1155Deroll -- transfer --> Anyone
    ERC1155Deroll -- ... --> Anyone
```

## 3. How to run:

```bash
make setup
```

```bash
make test
```

```bash
make deploy
```
