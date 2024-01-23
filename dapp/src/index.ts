import { createApp } from "@deroll/app";
import { createRouter } from "@deroll/router";
import { createWallet } from "@deroll/wallet";
import { decodeFunctionData, parseAbi, Address} from "viem";

console.log("Creating app...");

// create app
const app = createApp({ url: "http://127.0.0.1:5004" });

const abi = parseAbi([
    "function transferEther(address from, address to, uint256 amount)",
    "function transferERC20(address token, address from, address to, uint256 amount)",
    "function withdrawEther(address to, uint256 amount)",
    "function withdrawERC20(address token, address to, uint256 amount)"
]);

app.addAdvanceHandler(async ({ payload, metadata }) => {
    try { 
        const { functionName, args } = decodeFunctionData({ abi, data: payload });
        let from, to, amount, token, status;
        switch (functionName) {
            case "transferEther":
                [from, to, amount] = args;
                wallet.transferEther(from, to, amount);
                console.log(`The account ${metadata.msg_sender} is transferring ${amount} wei from ${from} to ${to} at ${metadata.timestamp}`)
                return "accept";
            case "transferERC20":
                [token, from, to, amount] = args;
                wallet.transferERC20(token, from, to, amount);
                console.log(`The account ${metadata.msg_sender} is transferring ${amount} tokens of ${token} from ${from} to ${to} at ${metadata.timestamp}`)
                return "accept";
            case "withdrawEther":
                [to, amount] = args;
                status = app.createVoucher(wallet.withdrawEther(to, amount));
                console.log(`The account ${metadata.msg_sender} is withdrawing ${amount} wei at ${metadata.timestamp}.`)
                return "accept";
            case "withdrawERC20":
                [token, to, amount] = args;
                status = app.createVoucher(wallet.withdrawERC20(token, to, amount));
                console.log(`The account ${metadata.msg_sender} is withdrawing ${amount} tokens of ${token} at ${metadata.timestamp}.`)
                return "accept";
        }
    } catch(e) {
        return "reject";
    }
});

// create wallet
const wallet = createWallet();

const router = createRouter({ app });

router.add<{ sender: string }>(
    "wallet/ether/:sender",
    ({ params: { sender } }) => {
        return JSON.stringify({
            balance: wallet.balanceOf(sender).toString(),
        });
    },
);

router.add<{ token: Address, sender: string}>(
    "wallet/erc20/:token/:sender",
    ({ params: { token, sender } }) => {
        return JSON.stringify({
            balance: wallet.balanceOf(token, sender).toString(),
        });
    },
);

app.addAdvanceHandler(wallet.handler);
app.addInspectHandler(router.handler);

// start app
app.start().catch((e) => {
    console.error("Error starting the app:", e);
    process.exit(1);
});
