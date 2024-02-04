## Introduction:

The content below contains instructions on how to interact with the application. This app was built using Deroll, a Cartesi high-level framework written in TypeScript.

## User Stories:

Here is a list of user stories that the application covers:

| #   | User Story Description                                                                                     |
| --- | ---------------------------------------------------------------------------------------------------------- |
| 1   | As a user, I want to send Ether tokens to my wallet on Layer 2.                                           |
| 2   | As a user, I want to send ERC20 tokens to my wallet on Layer 2.                                           |
| 3   | As a user, I want to transfer Ether tokens between wallets on Layer 2.                                    |
| 4   | As a user, I want to transfer ERC20 tokens between wallets on Layer 2.                                    |
| 5   | As a user, I want to withdraw my deposit in ERC20.                                                         |
| 6   | As a user, I want to withdraw my deposit in Ether.                                                         |
| 7   | As a user, I want to request the balance of Ether in my wallet on Layer 2.                                |
| 8   | As a user, I want to request the balance of ERC20 tokens in my wallet on Layer 2.                         |
| 9   | As a user, I want to deploy any contract.                                                                  |
| 10  | As a user, I want to request the minting of an NFT (ERC721) for my address on Layer 1.                    |
| 11  | As a user, I want to request the minting of NFTs (ERC1155) for my address on Layer 1.                     |

## Setup:

#### The system setup is divided into four parts:

1º - First of all, clone this repo using the code below:
```Bash
git clone --recursive git@github.com:Mugen-Builders/echo-plus-deroll.git
```
    
2º - You should follow the [instructions](https://github.com/Mugen-Builders/echo-plus-deroll/tree/main/dapp) to build the application and run ( Choose the best mode for you. ) it using [Sunodo](https://docs.sunodo.io/guide/introduction/what-is-sunodo) or [Nonodo](https://github.com/gligneul/nonodo)

3º - Now you can start the web frontend that will assist you in interacting with the application. Follow these [instructions](https://github.com/prototyp3-dev/frontend-web-cartesi?tab=readme-ov-file#available-scripts).

4º - After that, follow the [instructions](https://github.com/Mugen-Builders/echo-plus-deroll/tree/main/contracts#3-how-to-run) for deploying the contracts.

_**Once you have completed this process, the application setup is ready for the interactions section.**_

## Interactions:

Below are the instructions on how to interact with each section of the application, and some metadata of the performed operation.

#### Send native tokens:

_User story number 1_

_Required past interactions: No past interactions._

##### Step 1:

###### Command:

```shell
sunodo send ether --amount=1000
```

###### Output:

```shell
? Chain Foundry
? RPC URL http://127.0.0.1:8545
? Wallet Mnemonic
? Mnemonic test test test test test test test test test test test junk
? Account 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 9999.969240420387558666 ETH
? DApp address 0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C
✔ Input sent: 0x748c08e26d4898384ab0a0cdea7a41bfc7fe0138300133e6cdcf8733b245acf7
```

> [!NOTE]
> - Request Type: Advance State
> - Contract Name: EtherPortal
> - Contract Function: "depositEther(address app, bytes calldata execLayerData)"
> - Contract Address: 0xFfdbe43d4c855BF7e0f105c400A50857f53AB044

#### Balance of native tokens:

_User story number 7_

_Required past interactions: Send native tokens._

##### Step 1:

###### Command:

```Bash
curl http://localhost:8080/inspect/wallet/ether/0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
```

###### Output:

```json
{
   "status":"Accepted",
   "exception_payload":null,
   "reports":[
      {
         "payload":"0x7b2262616c616e6365223a2231303030303030303030303030303030303030303030227d"
      }
   ],
   "processed_input_count":1
}
```

> [!NOTE]
>  - Request Type: Inspect State

#### Transfer native tokens:

_User story number 3_

_Required past interactions: Send native tokens._

##### Step 1:

###### Command:
```Bash
cast calldata "transferEther(address,uint256)" 0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C 100
```

###### Output:
```Bash
0x05b1137b00000000000000000000000070ac08179605af2d9e75782b8decdd3c22aa4d0c0000000000000000000000000000000000000000000000000000000000000064
```

##### Step 2:

###### Command:
```Bash
sunodo send generic --input=0x05b1137b00000000000000000000000070ac08179605af2d9e75782b8decdd3c22aa4d0c0000000000000000000000000000000000000000000000000000000000000064
```

###### Output:
```shell
? Chain Foundry
? RPC URL http://127.0.0.1:8545
? Wallet Mnemonic
? Mnemonic test test test test test test test test test test test junk
? Account 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 8999.968880397279934808 ETH
? DApp address 0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C
✔ Input sent: 0xfa798512c244eeee3743aba4ecefb3ba60b180dc8f6a8fbd86832905a3423938
```
  
##### Evidence:

###### Command:

```Bash
curl http://localhost:8080/inspect/wallet/ether/0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C
```

###### Output:
```json
{
   "status":"Accepted",
   "exception_payload":null,
   "reports":[
      {
         "payload":"0x7b2262616c616e6365223a22313030303030303030303030303030303030303030227d"
      }
   ],
   "processed_input_count":2
}
```

> [!NOTE]
>  - Request Type: Advance State
>  - Contract Name: InputBox
>  - Contract Function: "addInput(address app, bytes calldata payload)"
>  - Contract Address: 0x59b22D57D4f067708AB0c00552767405926dc768

#### Withdraw native tokens:

_User story number 6_ 

_Required past interactions: Send native tokens._

##### Step 1:

###### Command:

```Bash
sunodo send dapp-address
```

###### Output:

```shell
? Chain Foundry
? RPC URL http://127.0.0.1:8545
? Wallet Mnemonic
? Mnemonic test test test test test test test test test test test junk
? Account 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 8999.968561869278177808 ETH
? DApp address 0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C
✔ Input sent: 0x96d438d042aa539bf1f99d1055aa829e8bd1082fff8fcb5929c929abc0e8012c
```

##### Step 2:

###### Command:

```Bash
cast calldata "withdrawEther(uint256)" 500ether
```

###### Output:

```Bash
0x3bed33ce00000000000000000000000000000000000000000000000000000000000001f4
```

##### Step 3:

###### Command:
```Bash
sunodo send generic --input=0x3bed33ce00000000000000000000000000000000000000000000000000000000000001f4
```

###### Output:
```Shell
? Chain Foundry
? RPC URL http://127.0.0.1:8545
? Wallet Mnemonic
? Mnemonic test test test test test test test test test test test junk
? Account 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 8999.968241325276378472 ETH
? DApp address 0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C
✔ Input sent: 0x758a7653c3429595a46ed0f5857d3c2fd106b67a0360677c2ace073f574a68fe
```

##### Evidence:

###### Command:
```shell
curl http://localhost:8080/inspect/wallet/ether/0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
```

###### Output:
```json
{
   "status":"Accepted",
   "exception_payload":null,
   "reports":[
      {
         "payload":"0x7b2262616c616e6365223a22343030303030303030303030303030303030303030227d"
      }
   ],
   "processed_input_count":4
}
```

> [!NOTE]
> - Request Type: Advance State
> - Contract Name: InputBox
> - Contract Function: "addInput(address app, bytes calldata payload)"
> - Contract Address: 0x59b22D57D4f067708AB0c00552767405926dc768

#### Send Tokens ERC20:

_User story number 2_

_Required past interactions: No past interactions._

##### Step 1:

###### Command:
```Bash
cast send 0xae7f61eCf06C65405560166b259C54031428A9C4 "approve(address,uint256)" 0x9C21AEb2093C32DDbC53eEF24B873BDCd1aDa1DB 10000000000000000000000000000 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --rpc-url http://localhost:8545
```

###### Output:
```Shell
blockHash               0xda6c54e8df9ddfad5ef22d9efb5714bbc2b0c4650b033e89c3fb2025cd341aea
blockNumber             445
contractAddress         
cumulativeGasUsed       46969
effectiveGasPrice       3000000007
gasUsed                 46969
logs                    [{"address":"0xae7f61ecf06c65405560166b259c54031428a9c4","topics":["0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925","0x000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb92266","0x0000000000000000000000009c21aeb2093c32ddbc53eef24b873bdcd1ada1db"],"data":"0x0000000000000000000000000000000000000000204fce5e3e25026110000000","blockHash":"0xda6c54e8df9ddfad5ef22d9efb5714bbc2b0c4650b033e89c3fb2025cd341aea","blockNumber":"0x1bd","transactionHash":"0x863d8e429894f5bc7aea7282c5878815fcee7f207882cb6d59416c180f119f44","transactionIndex":"0x0","logIndex":"0x0","transactionLogIndex":"0x0","removed":false}]
logsBloom               0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000800000000000000000000080000000000000000000000000100000000000000000000000000000020000000000000000000000000000000000000000000000800000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000002000000000008000000000000010000000400000000000000000000000000000000000000000000000000000
root                    
status                  1
transactionHash         0x863d8e429894f5bc7aea7282c5878815fcee7f207882cb6d59416c180f119f44
transactionIndex        0
type                    2
```

##### Step 2:

###### Command:
```Bash
sunodo send erc20
```

###### Output:
```Shell
? Chain Foundry
? RPC URL http://127.0.0.1:8545
? Wallet Mnemonic
? Mnemonic test test test test test test test test test test test junk
? Account 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 8999.967782517274305856 ETH
? DApp address 0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C
? Token address 0xae7f61eCf06C65405560166b259C54031428A9C4
✔ Input sent: 0xc9f85574c90461c920972ba5e00de03b05477e022e50f72aebad898af6757a6c
```
  
> [!NOTE]
>  - Request Type: Advance State
>  - Contract Name: ERC20Portal
>  - Contract Function: "depositERC20Tokens(IERC20 token, address app, uint256 amount, bytes calldata execLayerData)"
>  - Contract Address: 0x9C21AEb2093C32DDbC53eEF24B873BDCd1aDa1DB

#### Balance of ERC20 tokens:

_User story number 8_

_Required past interactions: Send ERC20 tokens._

##### Step 1:

###### Command:
```Bash
curl http://localhost:8080/inspect/wallet/erc20/0xae7f61eCf06C65405560166b259C54031428A9C4/0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
```

###### Output:
```Bash
{
   "status":"Accepted",
   "exception_payload":null,
   "reports":[
      {
         "payload":"0x7b2262616c616e6365223a2231303030303030303030303030303030303030227d"
      }
   ],
   "processed_input_count":5
}
```

> [!NOTE]
>  - Request Type: Inspect State

#### Transfer tokens ERC20:

_User story number 4_

_Required past interactions: Send ERC20 tokens._

##### Step 1:

###### Command:
```Bash
cast calldata "transferERC20(address,address,uint256)" 0xae7f61eCf06C65405560166b259C54031428A9C4 0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C 1000
```

###### Output:
```Bash
0x9db5dbe4000000000000000000000000ae7f61ecf06c65405560166b259c54031428a9c400000000000000000000000070ac08179605af2d9e75782b8decdd3c22aa4d0c00000000000000000000000000000000000000000000000000000000000003e8
```

##### Step 2:

###### Command:
```Shell
sunodo send generic --input=0x9db5dbe4000000000000000000000000ae7f61ecf06c65405560166b259c54031428a9c400000000000000000000000070ac08179605af2d9e75782b8decdd3c22aa4d0c00000000000000000000000000000000000000000000000000000000000003e8
```

###### Output:
```Shell
? Chain Foundry
? RPC URL http://127.0.0.1:8545
? Wallet Mnemonic
? Mnemonic test test test test test test test test test test test junk
? Account 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 8999.967416214271545581 ETH
? DApp address 0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C
✔ Input sent: 0xd49dc708491b48e6789e7dbc635474fa83fb19da2f7a6326a9cb5c4131fdd733`
```

##### Evidence:

###### Command:
```Bash
curl http://localhost:8080/inspect/wallet/erc20/0xae7f61eCf06C65405560166b259C54031428A9C4/0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C
```

###### Output:
```json
{
   "status":"Accepted",
   "exception_payload":null,
   "reports":[
      {
         "payload":"0x7b2262616c616e6365223a2231303030227d"
      }
   ],
   "processed_input_count":6
}
```

> [!NOTE]
>  - Request Type: Advance State
>  - Contract Name: InputBox
>  - Contract Function: "addInput(address app, bytes calldata payload)"
>  - Contract Address: 0x59b22D57D4f067708AB0c00552767405926dc768

#### Withdraw ERC20 tokens:

_User story number 5_

_Required past interactions: Send ERC20 tokens._

##### Step 1:

###### Command:
```Bash
cast calldata "withdrawERC20(address,uint256)" 0xae7f61eCf06C65405560166b259C54031428A9C4 500
```

###### Output:
```Bash
0xa1db9782000000000000000000000000ae7f61ecf06c65405560166b259c54031428a9c400000000000000000000000000000000000000000000000000000000000001f4
```

##### Step 2:

###### Command:
```Bash
sunodo send generic --input=0xa1db9782000000000000000000000000ae7f61ecf06c65405560166b259c54031428a9c400000000000000000000000000000000000000000000000000000000000001f4
```

###### Output:
```Shell
? Chain Foundry
? RPC URL http://127.0.0.1:8545
? Wallet Mnemonic
? Mnemonic test test test test test test test test test test test junk
? Account 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 8999.96709703526977491 ETH
? DApp address 0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C
✔ Input sent: 0x383138528e451dfb74286e8f84d6282e2718ecc92e66ad91e18f2059437de501
```

##### Evidence:

###### Command:
```Bash
curl http://localhost:8080/inspect/wallet/erc20/0xae7f61eCf06C65405560166b259C54031428A9C4/0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
```

###### Output:
```json
{
   "status":"Accepted",
   "exception_payload":null,
   "reports":[
      {
         "payload":"0x7b2262616c616e6365223a22393939393939393939393939393938353030227d"
      }
   ],
   "processed_input_count":7
}
```

> [!NOTE]:
>  - Request Type: Advance State
>  - Contract Name: InputBox
>  - Contract Function: "addInput(address app, bytes calldata payload)"
>  - Contract Address: 0x59b22D57D4f067708AB0c00552767405926dc768

#### Deploy any contract:

_User story number 9_

_Required past interactions: No past interactions._

##### Step 1:

Go to the following [link](https://remix.ethereum.org/#code=Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVA0KcHJhZ21hIHNvbGlkaXR5IF4wLjguMjA7DQoNCmNvbnRyYWN0IENvdW50ZXIgew0KICAgIHVpbnQyNTYgcHVibGljIG51bWJlcjsNCg0KICAgIGZ1bmN0aW9uIHNldE51bWJlcih1aW50MjU2IG5ld051bWJlcikgcHVibGljIHsNCiAgICAgICAgbnVtYmVyID0gbmV3TnVtYmVyOw0KICAgIH0NCg0KICAgIGZ1bmN0aW9uIGluY3JlbWVudCgpIHB1YmxpYyB7DQogICAgICAgIG51bWJlcisrOw0KICAgIH0NCn0NCg0KY29udHJhY3QgSGVscGVyIHsNCiAgICBmdW5jdGlvbiBnZXRDb3VudGVyQnl0ZWNvZGUoKSBleHRlcm5hbCBwdXJlIHJldHVybnMgKGJ5dGVzIG1lbW9yeSkgew0KICAgICAgICBieXRlcyBtZW1vcnkgYnl0ZWNvZGUgPSB0eXBlKENvdW50ZXIpLmNyZWF0aW9uQ29kZTsNCiAgICAgICAgcmV0dXJuIGJ5dGVjb2RlOw0KICAgIH0NCn0=) and follow the steps below to get the contract bytecode:

https://github.com/Mugen-Builders/echo-plus-deroll/assets/89201795/60949e13-108a-490a-98b0-d5017b0c6212

##### Step 2:

###### Command:
```Bash
cast calldata "deployAnyContract(bytes)" 0x608060405234801561000f575f80fd5b506101e18061001d5f395ff3fe608060405234801561000f575f80fd5b506004361061003f575f3560e01c80633fb5c1cb146100435780638381f58a1461005f578063d09de08a1461007d575b5f80fd5b61005d600480360381019061005891906100e4565b610087565b005b610067610090565b604051610074919061011e565b60405180910390f35b610085610095565b005b805f8190555050565b5f5481565b5f808154809291906100a690610164565b9190505550565b5f80fd5b5f819050919050565b6100c3816100b1565b81146100cd575f80fd5b50565b5f813590506100de816100ba565b92915050565b5f602082840312156100f9576100f86100ad565b5b5f610106848285016100d0565b91505092915050565b610118816100b1565b82525050565b5f6020820190506101315f83018461010f565b92915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f61016e826100b1565b91507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff82036101a05761019f610137565b5b60018201905091905056fea26469706673582212207a12f707da17828060fd547511819a06638043efa370739f58abc0354de30be064736f6c63430008160033
```

###### Output:
```Bash
0xe03014e7000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000001fe608060405234801561000f575f80fd5b506101e18061001d5f395ff3fe608060405234801561000f575f80fd5b506004361061003f575f3560e01c80633fb5c1cb146100435780638381f58a1461005f578063d09de08a1461007d575b5f80fd5b61005d600480360381019061005891906100e4565b610087565b005b610067610090565b604051610074919061011e565b60405180910390f35b610085610095565b005b805f8190555050565b5f5481565b5f808154809291906100a690610164565b9190505550565b5f80fd5b5f819050919050565b6100c3816100b1565b81146100cd575f80fd5b50565b5f813590506100de816100ba565b92915050565b5f602082840312156100f9576100f86100ad565b5b5f610106848285016100d0565b91505092915050565b610118816100b1565b82525050565b5f6020820190506101315f83018461010f565b92915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f61016e826100b1565b91507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff82036101a05761019f610137565b5b60018201905091905056fea26469706673582212207a12f707da17828060fd547511819a06638043efa370739f58abc0354de30be064736f6c634300081600330000
```

##### Step 2:

###### Command:
```Bash
sunodo send generic --input=0xe03014e7000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000001fe608060405234801561000f575f80fd5b506101e18061001d5f395ff3fe608060405234801561000f575f80fd5b506004361061003f575f3560e01c80633fb5c1cb146100435780638381f58a1461005f578063d09de08a1461007d575b5f80fd5b61005d600480360381019061005891906100e4565b610087565b005b610067610090565b604051610074919061011e565b60405180910390f35b610085610095565b005b805f8190555050565b5f5481565b5f808154809291906100a690610164565b9190505550565b5f80fd5b5f819050919050565b6100c3816100b1565b81146100cd575f80fd5b50565b5f813590506100de816100ba565b92915050565b5f602082840312156100f9576100f86100ad565b5b5f610106848285016100d0565b91505092915050565b610118816100b1565b82525050565b5f6020820190506101315f83018461010f565b92915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f61016e826100b1565b91507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff82036101a05761019f610137565b5b60018201905091905056fea26469706673582212207a12f707da17828060fd547511819a06638043efa370739f58abc0354de30be064736f6c634300081600330000
```

###### Output:
```Shell
? Chain Foundry
? RPC URL http://127.0.0.1:8545
? Wallet Mnemonic
? Mnemonic test test test test test test test test test test test junk
? Account 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 8999.966778495268017658 ETH
? DApp address 0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C
✔ Input sent: 0x85c54fdeadf8ae6a1c04d26d3d0930af829403bb709b0260b6a70c0414ef0333
```

##### Evidence:

###### Command:
```Bash
curl -X POST -H "Content-Type: application/json" -d '{"query": "query { vouchers(last: 1) { edges { node { index input { index } destination payload } } } }"}' http://localhost:8080/graphql
```

###### Output:
```json
{
  "data": {
    "vouchers": {
      "edges": [
        {
          "node": {
            "index": 0,
            "input": {
              "index": 7
            },
            "destination": "0xddddeea5b5faa61d9095383bcf229268af700b93",
            "payload": "0xe03014e7000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000001fe608060405234801561000f575f80fd5b506101e18061001d5f395ff3fe608060405234801561000f575f80fd5b506004361061003f575f3560e01c80633fb5c1cb146100435780638381f58a1461005f578063d09de08a1461007d575b5f80fd5b61005d600480360381019061005891906100e4565b610087565b005b610067610090565b604051610074919061011e565b60405180910390f35b610085610095565b005b805f8190555050565b5f5481565b5f808154809291906100a690610164565b9190505550565b5f80fd5b5f819050919050565b6100c3816100b1565b81146100cd575f80fd5b50565b5f813590506100de816100ba565b92915050565b5f602082840312156100f9576100f86100ad565b5b5f610106848285016100d0565b91505092915050565b610118816100b1565b82525050565b5f6020820190506101315f83018461010f565b92915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f61016e826100b1565b91507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff82036101a05761019f610137565b5b60018201905091905056fea26469706673582212207a12f707da17828060fd547511819a06638043efa370739f58abc0354de30be064736f6c634300081600330000"
          }
        }
      ]
    }
  }
}
```

> [!NOTE]
>  - Request Type: Advance State
>  - Contract Name: InputBox
>  - Contract Function: "addInput(address app, bytes calldata payload)"
>  - Contract Address: 0x59b22D57D4f067708AB0c00552767405926dc768

#### Mint an NFT (ERC721):

_User story number 10_ 

_Required past interactions: No past interactions._

##### Step 1:

###### Command:
```Bash
cast calldata "safeMint(address,string)" 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 "QmbuvUU1cauPMEivFLX3v86fJvY6zvaydjCvzBASty372Y"
```

###### Output:
```Bash
0xd204c45e000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb922660000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000002e516d627576555531636175504d456976464c5833763836664a7659367a766179646a43767a424153747933373257000000000000000000000000000000000000
```

##### Step 2:

###### Command:
```Bash
sunodo send generic --input=0xd204c45e000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb922660000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000002e516d627576555531636175504d456976464c5833763836664a7659367a766179646a43767a424153747933373257000000000000000000000000000000000000
```

###### Output:
```Shell
? Chain Foundry
? RPC URL http://127.0.0.1:8545
? Wallet Mnemonic
? Mnemonic test test test test test test test test test test test junk
? Account 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 8999.966448385266017436 ETH
? DApp address 0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C
✔ Input sent: 0x435ec31d04b080afe8eb634b0d2798388048ad2dd7f18c80affbcdb856c548af
```

##### Evidence:

###### Command:
```Bash
curl -X POST -H "Content-Type: application/json" -d '{"query": "query { vouchers(last: 1) { edges { node { index input { index } destination payload } } } }"}' http://localhost:8080/graphql
```

###### Output:
```Bash
{
   "data":{
      "vouchers":{
         "edges":[
            {
               "node":{
                  "index":0,
                  "input":{
                     "index":8
                  },
                  "destination":"0x2b1a74616f146bc609924a1aee1cdb67f258d794",
                  "payload":"0xd204c45e000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb922660000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000004368747470733a2f2f697066732e696f2f697066732f516d627576555531636175504d456976464c5833763836664a7659367a766179646a43767a4241537479333732570000000000000000000000000000000000000000000000000000000000"
               }
            }
         ]
      }
   }
}
```

> [!NOTE]
>  - Request Type: Advance State
>  - Contract Name: InputBox
>  - Contract Function: "addInput(address app, bytes calldata payload)"
>  - Contract Address: 0x59b22D57D4f067708AB0c00552767405926dc768

#### Mint NFTs (ERC1155)

_User story number 11_

_Required past interactions: No past interactions._

##### Step 1:

###### Command:
```Bash
cast calldata "mint(address,uint256,uint256,bytes)" 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 1 100 0x00
```

###### Output:
```Bash
0x731133e9000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000064000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000
```

##### Step 2:

###### Command:
```Bash
sunodo send generic --input=0x731133e9000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000064000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000
```

###### Output:
```Shell
? Chain Foundry
? RPC URL http://127.0.0.1:8545
? Wallet Mnemonic
? Mnemonic test test test test test test test test test test test junk
? Account 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 8999.966128131264223518 ETH
? DApp address 0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C
✔ Input sent: 0x6d23fc1b6b0c9ed285dc95d2742fa0d62d858f8fcecba2fc3751264f2f39d6cb
```

##### Evidence:

###### Command
```Bash
curl -X POST -H "Content-Type: application/json" -d '{"query": "query { vouchers(last: 1) { edges { node { index input { index } destination payload } } } }"}' http://localhost:8080/graphql
```

###### Output:
```Bash
{
   "data":{
      "vouchers":{
         "edges":[
            {
               "node":{
                  "index":0,
                  "input":{
                     "index":9
                  },
                  "destination":"0x4c4d35e8bf193183c1e5d66397a475c3c78c4f9d",
                  "payload":"0x731133e9000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000064000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000"
               }
            }
         ]
      }
   }
}
```

> [!NOTE]
>  - Request Type: Advance State
>  - Contract Name: InputBox
>  - Contract Function: "addInput(address app, bytes calldata payload)"
>  - Contract Address: 0x59b22D57D4f067708AB0c00552767405926dc768

### Executing all generated vouchers

You can use the voucher section of the [frontend](http://localhost:3000) to execute all the vouchers generated by the interactions performed earlier.
![image](https://github.com/Mugen-Builders/echo-plus-deroll/assets/89201795/6a989b97-fda5-43a1-89d2-0c763b1ac06d)
