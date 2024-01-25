## Introduction:

- The content below contains instructions on how to interact with the application. This app was built using Deroll, a Cartesi high-level framework written in TypeScript.

## User Stories:

- Here we are going to list all the user stories that the application covers:

  ```
  1st "As a user, I want to send Ether tokens to my wallet on Layer 2."

  2nd "As a user, I want to send ERC20 tokens to my wallet on Layer 2."

  3rd "As a user, I want to transfer Ether tokens between wallets on Layer 2."

  4rd "As a user, I want to transfer ERC20 tokens between wallets on Layer 2."

  5th "As a user, I want to withdraw my deposit in ERC20."

  6th "As a user, I want to withdraw my deposit in Ether."

  7th "As a user, I want to request the balance of Ether of my wallet on Layer 2."

  8th "As a user, I want to request the balance of ERC20 tokens of my wallet on Layer 2."

  9th "As a user, I want to deploy any contract"

  10th "As a user, I want to request the minting of an NFT ( ERC721 ) for my address on Layer 1"

  11th "As a user, I want to request the minting of NFTs ( ERC1155 ) for my address on Layer 1."
  ```

## Setup:

- The system setup is divided into four parts:

  - First of all, clone this repo using the code below:
    ```Bash
    git clone --recursive git@github.com:Mugen-Builders/echo-plus-deroll.git
    ```
    
  - You should follow the [instructions](https://github.com/Mugen-Builders/echo-plus-deroll/tree/main/dapp) to build the application and run ( Choose the best mode for you. ) it using [Sunodo](https://docs.sunodo.io/guide/introduction/what-is-sunodo).

  - Now you can start the web frontend that will assist you in interacting with the application. Follow these [instructions](https://github.com/prototyp3-dev/frontend-web-cartesi?tab=readme-ov-file#available-scripts).

  - After that, follow the [instructions](https://github.com/Mugen-Builders/echo-plus-deroll/tree/main/contracts#3-how-to-run) for deploying the contracts.

***Once you have completed this process, the application setup is ready for the Interactions section.***

## Interactions:

- Below are the instructions on how to interact with each section of the application, and some metadata of the performed operation.

#### Send native tokens:

- User story number 1
- Required past interactions: No past interactions.
- Step 1:
  ```Bash
  sunodo send ether --amount=1000
  ```
  ![image](https://github.com/Mugen-Builders/echo-plus-deroll/assets/89201795/597990ff-7799-415e-b30d-9e9fd42bda11)

  Or use the [frontend](http://localhost:3000)

- INFO:
  - Request Type: Advance State
  - Contract Name: EtherPortal
  - Contract Function: "depositEther(address app, bytes calldata execLayerData)"
  - Contract Address: 0xFfdbe43d4c855BF7e0f105c400A50857f53AB044

#### Balance of native tokens:

- User story number 7
- Required past interactions: Send native tokens.
- Step 1:
  ```Bash
  curl http://localhost:8080/inspect/wallet/ether/0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
  ```
  - Output:
    ```Bash
    {"status":"Accepted","exception_payload":null,"reports":[{"payload":"0x7b2262616c616e6365223a2231303030303030303030303030303030303030303030227d"}],"processed_input_count":1}%
    ```
- INFO:
  - Request Type: Inspect State

#### Transfer native tokens:

- User story number 3
- Required past interactions: Send native tokens.
- Step 1:
  ```Bash
  cast calldata "transferEther(address,address,uint256)" 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C 100
  ```
   - Output:
    ```Bash
    0x0e96127a000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000070ac08179605af2d9e75782b8decdd3c22aa4d0c0000000000000000000000000000000000000000000000000000000000000064
    ```
- Step 2:
  ```Bash
  sunodo send generic --input=0x0e96127a000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000070ac08179605af2d9e75782b8decdd3c22aa4d0c0000000000000000000000000000000000000000000000000000000000000064
  ```
  ![image](https://github.com/Mugen-Builders/echo-plus-deroll/assets/89201795/176d516d-3f8b-4ac3-9514-b686d5e3c3e0)
  
- Evidence:
  ```Bash
  curl http://localhost:8080/inspect/wallet/ether/0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C
  ```
  - Output:
    ```Bash
    {"status":"Accepted","exception_payload":null,"reports":[{"payload":"0x7b2262616c616e6365223a22313030303030303030303030303030303030303030227d"}],"processed_input_count":2}%
    ```
- INFO:
  - Request Type: Advance State
  - Contract Name: InputBox
  - Contract Function: "addInput(address app, bytes calldata payload)"
  - Contract Address: 0x59b22D57D4f067708AB0c00552767405926dc768

#### Withdraw native tokens:

- User story number 6
- Required past interactions: Send native tokens.
- Step 1:
  ```Bash
  sunodo send dapp-address
  ```
  ![image](https://github.com/Mugen-Builders/echo-plus-deroll/assets/89201795/490ba452-9181-4ade-8250-493336dec7f7)

- Step 2:
  ```Bash
  cast calldata "withdrawEther(address,uint256)" 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 500
  ```
  - Output:
    ```Bash
    0x522f6815000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000000000000000000000000000000000000000001f4
    ```
- Step 3:
  ```Bash
  sunodo send generic --input=0x522f6815000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000000000000000000000000000000000000000001f4
  ```
  ![image](https://github.com/Mugen-Builders/echo-plus-deroll/assets/89201795/90db39bc-5dc8-4449-9192-066055a1b93e)

- Evidence:
  ```Bash
  curl http://localhost:8080/inspect/wallet/ether/0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
  ```
  - Output:
    ```Bash
    {"status":"Accepted","exception_payload":null,"reports":[{"payload":"0x7b2262616c616e6365223a22343030303030303030303030303030303030303030227d"}],"processed_input_count":4}%
    ```
- INFO:
  - Request Type: Advance State
  - Contract Name: InputBox
  - Contract Function: "addInput(address app, bytes calldata payload)"
  - Contract Address: 0x59b22D57D4f067708AB0c00552767405926dc768

#### Send Tokens ERC20:

- User story number 2
- Required past interactions: No past interactions.
- Step 1:
  ```Bash
  cast send 0xae7f61eCf06C65405560166b259C54031428A9C4 "approve(address,uint256)" 0x9C21AEb2093C32DDbC53eEF24B873BDCd1aDa1DB 10000000000000000000000000000 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --rpc-url http://localhost:8545
  ```
- Step 2:
  ```Bash
  sunodo send erc20
  ```
  ![image](https://github.com/Mugen-Builders/echo-plus-deroll/assets/89201795/512e3938-2cd5-4104-8aa7-645c85117979)

  Or use the [frontend](http://localhost:3000) in this case you can choose between ERC20Deroll ( Contract Address: 0xBE9592fD0a56F2aD2090C2266D33D9DAd9C5Cf09 ) and SunodoToken ( Contract Address: 0xae7f61eCf06C65405560166b259C54031428A9C4 )

- INFO:
  - Request Type: Advance State
  - Contract Name: ERC20Portal
  - Contract Function: "depositERC20Tokens(IERC20 token, address app, uint256 amount, bytes calldata execLayerData))"
  - Contract Address: 0x9C21AEb2093C32DDbC53eEF24B873BDCd1aDa1DB

#### Balance of ERC20 tokens:

- User story number 8
- Required past interactions: Send ERC20 tokens.
- Step 1:
  ```Bash
  curl http://localhost:8080/inspect/wallet/erc20/0xae7f61eCf06C65405560166b259C54031428A9C4/0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
  ```
  - Output:
    ```Bash
    {"status":"Accepted","exception_payload":null,"reports":[{"payload":"0x7b2262616c616e6365223a2231303030303030303030303030303030303030227d"}],"processed_input_count":5}%
    ```
- INFO:
  - Request Type: Inspect State

#### Transfer tokens ERC20:

- User story number 4
- Required past interactions: Send ERC20 tokens.
- Step 1:
  ```Bash
  cast calldata "transferERC20(address,address,address,uint256)" 0xae7f61eCf06C65405560166b259C54031428A9C4 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C 1000
  ```
  - Output:
    ```Bash
    0xda3e8ce4000000000000000000000000ae7f61ecf06c65405560166b259c54031428a9c4000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000070ac08179605af2d9e75782b8decdd3c22aa4d0c00000000000000000000000000000000000000000000000000000000000003e8
    ```
- Step 2:
  ```Bash
  sunodo send generic --input=0xda3e8ce4000000000000000000000000ae7f61ecf06c65405560166b259c54031428a9c4000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000070ac08179605af2d9e75782b8decdd3c22aa4d0c00000000000000000000000000000000000000000000000000000000000003e8
  ```
  ![image](https://github.com/Mugen-Builders/echo-plus-deroll/assets/89201795/0a4d4933-c652-46db-a1ee-7942314ef774)

- Evidence:
  ```Bash
  curl http://localhost:8080/inspect/wallet/erc20/0xae7f61eCf06C65405560166b259C54031428A9C4/0x70ac08179605AF2D9e75782b8DEcDD3c22aA4D0C
  ```
    - Output:
      ```Bash
      {"status":"Accepted","exception_payload":null,"reports":[{"payload":"0x7b2262616c616e6365223a2231303030227d"}],"processed_input_count":6}%
      ```
- INFO:
  - Request Type: Advance State
  - Contract Name: InputBox
  - Contract Function: "addInput(address app, bytes calldata payload)"
  - Contract Address: 0x59b22D57D4f067708AB0c00552767405926dc768

#### Withdraw ERC20 tokens:

- User story number 5
- Required past interactions: Send ERC20 tokens.
- Step 1:
  ```Bash
  cast calldata "withdrawERC20(address,address,uint256)" 0xae7f61eCf06C65405560166b259C54031428A9C4 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 500
  ```
  - Output:
    ```Bash
    0x44004cc1000000000000000000000000ae7f61ecf06c65405560166b259c54031428a9c4000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000000000000000000000000000000000000000001f4
    ```
- Step 2:
  ```Bash
  sunodo send generic --input=0x44004cc1000000000000000000000000ae7f61ecf06c65405560166b259c54031428a9c4000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000000000000000000000000000000000000000001f4
  ```
  ![image](https://github.com/Mugen-Builders/echo-plus-deroll/assets/89201795/bd38e30a-a785-4062-b6e5-f5b0366ce0ff)

- Evidence:
  ```Bash
  curl http://localhost:8080/inspect/wallet/erc20/0xae7f61eCf06C65405560166b259C54031428A9C4/0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
  ```
    - Output:
      ```Bash
      {"status":"Accepted","exception_payload":null,"reports":[{"payload":"0x7b2262616c616e6365223a22393939393939393939393939393938353030227d"}],"processed_input_count":7}%
      ```
- INFO:
  - Request Type: Advance State
  - Contract Name: InputBox
  - Contract Function: "addInput(address app, bytes calldata payload)"
  - Contract Address: 0x59b22D57D4f067708AB0c00552767405926dc768

#### Deploy any contract:

- User story number 9
- Required past interactions: No past interactions.
- Step 1:
  - Go to the following [link](https://remix.ethereum.org/#code=Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVA0KcHJhZ21hIHNvbGlkaXR5IF4wLjguMjA7DQoNCmNvbnRyYWN0IENvdW50ZXIgew0KICAgIHVpbnQyNTYgcHVibGljIG51bWJlcjsNCg0KICAgIGZ1bmN0aW9uIHNldE51bWJlcih1aW50MjU2IG5ld051bWJlcikgcHVibGljIHsNCiAgICAgICAgbnVtYmVyID0gbmV3TnVtYmVyOw0KICAgIH0NCg0KICAgIGZ1bmN0aW9uIGluY3JlbWVudCgpIHB1YmxpYyB7DQogICAgICAgIG51bWJlcisrOw0KICAgIH0NCn0NCg0KY29udHJhY3QgSGVscGVyIHsNCiAgICBmdW5jdGlvbiBnZXRDb3VudGVyQnl0ZWNvZGUoKSBleHRlcm5hbCBwdXJlIHJldHVybnMgKGJ5dGVzIG1lbW9yeSkgew0KICAgICAgICBieXRlcyBtZW1vcnkgYnl0ZWNvZGUgPSB0eXBlKENvdW50ZXIpLmNyZWF0aW9uQ29kZTsNCiAgICAgICAgcmV0dXJuIGJ5dGVjb2RlOw0KICAgIH0NCn0=) and follow the steps below to get the contract bytecode:

    https://github.com/Mugen-Builders/echo-plus-deroll/assets/89201795/60949e13-108a-490a-98b0-d5017b0c6212
    
- Step 1:
  ```Bash
  cast calldata "deployAnyContract(bytes)" 0x608060405234801561000f575f80fd5b506101e18061001d5f395ff3fe608060405234801561000f575f80fd5b506004361061003f575f3560e01c80633fb5c1cb146100435780638381f58a1461005f578063d09de08a1461007d575b5f80fd5b61005d600480360381019061005891906100e4565b610087565b005b610067610090565b604051610074919061011e565b60405180910390f35b610085610095565b005b805f8190555050565b5f5481565b5f808154809291906100a690610164565b9190505550565b5f80fd5b5f819050919050565b6100c3816100b1565b81146100cd575f80fd5b50565b5f813590506100de816100ba565b92915050565b5f602082840312156100f9576100f86100ad565b5b5f610106848285016100d0565b91505092915050565b610118816100b1565b82525050565b5f6020820190506101315f83018461010f565b92915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f61016e826100b1565b91507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff82036101a05761019f610137565b5b60018201905091905056fea26469706673582212207a12f707da17828060fd547511819a06638043efa370739f58abc0354de30be064736f6c63430008160033
  ```
  - Output:
    ```Bash
    0xe03014e7000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000001fe608060405234801561000f575f80fd5b506101e18061001d5f395ff3fe608060405234801561000f575f80fd5b506004361061003f575f3560e01c80633fb5c1cb146100435780638381f58a1461005f578063d09de08a1461007d575b5f80fd5b61005d600480360381019061005891906100e4565b610087565b005b610067610090565b604051610074919061011e565b60405180910390f35b610085610095565b005b805f8190555050565b5f5481565b5f808154809291906100a690610164565b9190505550565b5f80fd5b5f819050919050565b6100c3816100b1565b81146100cd575f80fd5b50565b5f813590506100de816100ba565b92915050565b5f602082840312156100f9576100f86100ad565b5b5f610106848285016100d0565b91505092915050565b610118816100b1565b82525050565b5f6020820190506101315f83018461010f565b92915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f61016e826100b1565b91507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff82036101a05761019f610137565b5b60018201905091905056fea26469706673582212207a12f707da17828060fd547511819a06638043efa370739f58abc0354de30be064736f6c634300081600330000
    ```
- Step 2:
  ```Bash
  sunodo send generic --input=0xe03014e7000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000001fe608060405234801561000f575f80fd5b506101e18061001d5f395ff3fe608060405234801561000f575f80fd5b506004361061003f575f3560e01c80633fb5c1cb146100435780638381f58a1461005f578063d09de08a1461007d575b5f80fd5b61005d600480360381019061005891906100e4565b610087565b005b610067610090565b604051610074919061011e565b60405180910390f35b610085610095565b005b805f8190555050565b5f5481565b5f808154809291906100a690610164565b9190505550565b5f80fd5b5f819050919050565b6100c3816100b1565b81146100cd575f80fd5b50565b5f813590506100de816100ba565b92915050565b5f602082840312156100f9576100f86100ad565b5b5f610106848285016100d0565b91505092915050565b610118816100b1565b82525050565b5f6020820190506101315f83018461010f565b92915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f61016e826100b1565b91507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff82036101a05761019f610137565b5b60018201905091905056fea26469706673582212207a12f707da17828060fd547511819a06638043efa370739f58abc0354de30be064736f6c634300081600330000
  ```
  ![image](https://github.com/Mugen-Builders/echo-plus-deroll/assets/89201795/1dca1942-85be-4b3c-9db5-a0dfabe69d16)

- Evidence:
  ```Bash
  curl -X POST -H "Content-Type: application/json" -d '{"query": "query { vouchers(last: 1) { edges { node { index input { index } destination payload } } } }"}' http://localhost:8080/graphql
  ```
    - Output:
      ```Bash
      {"data":{"vouchers":{"edges":[{"node":{"index":0,"input":{"index":7},"destination":"0xddddeea5b5faa61d9095383bcf229268af700b93","payload":"0xe03014e7000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000001fe608060405234801561000f575f80fd5b506101e18061001d5f395ff3fe608060405234801561000f575f80fd5b506004361061003f575f3560e01c80633fb5c1cb146100435780638381f58a1461005f578063d09de08a1461007d575b5f80fd5b61005d600480360381019061005891906100e4565b610087565b005b610067610090565b604051610074919061011e565b60405180910390f35b610085610095565b005b805f8190555050565b5f5481565b5f808154809291906100a690610164565b9190505550565b5f80fd5b5f819050919050565b6100c3816100b1565b81146100cd575f80fd5b50565b5f813590506100de816100ba565b92915050565b5f602082840312156100f9576100f86100ad565b5b5f610106848285016100d0565b91505092915050565b610118816100b1565b82525050565b5f6020820190506101315f83018461010f565b92915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f61016e826100b1565b91507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff82036101a05761019f610137565b5b60018201905091905056fea26469706673582212207a12f707da17828060fd547511819a06638043efa370739f58abc0354de30be064736f6c634300081600330000"}}]}}}%
      ```
- INFO:
  - Request Type: Advance State
  - Contract Name: InputBox
  - Contract Function: "addInput(address app, bytes calldata payload)"
  - Contract Address: 0x59b22D57D4f067708AB0c00552767405926dc768

#### Mint an NFT (ERC721):

- User story number 10
- Required past interactions: No past interactions.
- Step 1:
  ```Bash
  cast calldata "safeMint(address,string)" 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 "https://ipfs.io/ipfs/QmbuvUU1cauPMEivFLX3v86fJvY6zvaydjCvzBASty372W"
  ```
- Output:
  ```Bash
  0xd204c45e000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb922660000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000004368747470733a2f2f697066732e696f2f697066732f516d627576555531636175504d456976464c5833763836664a7659367a766179646a43767a4241537479333732570000000000000000000000000000000000000000000000000000000000
  ```
- Step 2:
  ```Bash
  sunodo send generic --input=0xd204c45e000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb922660000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000004368747470733a2f2f697066732e696f2f697066732f516d627576555531636175504d456976464c5833763836664a7659367a766179646a43767a4241537479333732570000000000000000000000000000000000000000000000000000000000
  ```
  ![image](https://github.com/Mugen-Builders/echo-plus-deroll/assets/89201795/72aa70d3-74f6-48f8-a987-ee6740ef97f8)

- Evidence:
  ```Bash
  curl -X POST -H "Content-Type: application/json" -d '{"query": "query { vouchers(last: 1) { edges { node { index input { index } destination payload } } } }"}' http://localhost:8080/graphql
  ```
    - Output:
      ```Bash
      {"data":{"vouchers":{"edges":[{"node":{"index":0,"input":{"index":8},"destination":"0x2b1a74616f146bc609924a1aee1cdb67f258d794","payload":"0xd204c45e000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb922660000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000004368747470733a2f2f697066732e696f2f697066732f516d627576555531636175504d456976464c5833763836664a7659367a766179646a43767a4241537479333732570000000000000000000000000000000000000000000000000000000000"}}]}}}%
      ```
- INFO:
  - Request Type: Advance State
  - Contract Name: InputBox
  - Contract Function: "addInput(address app, bytes calldata payload)"
  - Contract Address: 0x59b22D57D4f067708AB0c00552767405926dc768

#### Mint NFTs (ERC1155)

- User story number 11
- Required past interactions: No past interactions.
- Step 1:
  ```Bash
  cast calldata "mint(address,uint256,uint256,bytes)" 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 1 100 0x00
  ```
  - Output:
    ```Bash
    0x731133e9000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000064000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000
    ```
- Step 2:
  ```Bash
  sunodo send generic --input=0x731133e9000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000064000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000
  ```
  ![image](https://github.com/Mugen-Builders/echo-plus-deroll/assets/89201795/a91f51b9-29bf-42ce-8642-a1fb064e4db2)

- Evidence:
  ```Bash
  curl -X POST -H "Content-Type: application/json" -d '{"query": "query { vouchers(last: 1) { edges { node { index input { index } destination payload } } } }"}' http://localhost:8080/graphql
  ```
  - Output:
    ```Bash
    {"data":{"vouchers":{"edges":[{"node":{"index":0,"input":{"index":9},"destination":"0x4c4d35e8bf193183c1e5d66397a475c3c78c4f9d","payload":"0x731133e9000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000064000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000"}}]}}}%
    ```
- INFO:
  - Request Type: Advance State
  - Contract Name: InputBox
  - Contract Function: "addInput(address app, bytes calldata payload)"
  - Contract Address: 0x59b22D57D4f067708AB0c00552767405926dc768

### Executing all generated vouchers

- You can use the voucher section of the [frontend](http://localhost:3000) to execute all the vouchers generated by the interactions performed earlier.