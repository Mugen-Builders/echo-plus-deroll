# DApp

Currently, there are two main ways to run your application. To learn more about the differences between each of them, access the [documentation](https://docs.cartesi.io/cartesi-rollups/build-dapps/dapp-host-mode/).

## Requirements

Please refer to the [rollups-examples requirements](https://github.com/cartesi/rollups-examples/tree/main/README.md#requirements).

This project works with [sunodo](https://github.com/sunodo/sunodo), so run it you should first install sunodo.

```shell
npm install -g @sunodo/cli
```

## Building

Build with:

```shell
sunodo build
```

## Running in Production Mode

Run with:

```shell
sunodo run --epoch-duration 60
```

## Running in Host-mode

Run with:

```shell
sunodo run --no-backend --epoch-duration 60
```