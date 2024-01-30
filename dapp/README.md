# DApp

Currently, there are two main ways to run your application. To learn more about the differences between each of them, access the [documentation](https://docs.cartesi.io/cartesi-rollups/build-dapps/dapp-host-mode/).

## Requirements

Please refer to the [rollups-examples requirements](https://github.com/cartesi/rollups-examples/tree/main/README.md#requirements). 

- To run using Sunodo. install the [package](https://github.com/sunodo/sunodo)
- To run using Nonodo, install the [binary](https://github.com/gligneul/nonodo)

```shell
npm install -g @sunodo/cli
```

## Building:

```shell
sunodo build
```

## Running in Production Mode:

```shell
sunodo run --epoch-duration 60
```

## Running using Nonodo:

```shell
npm i
nonodo -- npm start
```
