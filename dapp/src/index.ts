import { createApp } from "@deroll/app";
import { createRouter } from "@deroll/router";
import { createWallet } from "@deroll/wallet";
import {
  decodeFunctionData,
  encodeFunctionData,
  parseAbi,
  Address,
  toHex,
} from "viem";

const ROLLUP_SERVER =
  process.env.ROLLUP_HTTP_SERVER_URL || "http://127.0.0.1:5004";

const app = createApp({ url: ROLLUP_SERVER });

const abi = parseAbi(["function play(uint256)"]);

app.addAdvanceHandler(async ({ payload, metadata }) => {
  try {
    const { functionName, args } = decodeFunctionData({ abi, data: payload });
    let terms;
    switch (functionName) {
      case "play":
        [terms] = args;
        app.createVoucher({
          destination: "0xF0F73414cC05d6Ace602B3ae435Ca9ACF9e24bF2",
          payload: encodeFunctionData({
            abi: parseAbi(["function mint(address,uint256)"]),
            functionName: "mint",
            args: [
              metadata.msg_sender,
              BigInt(1000) * terms,
            ],
          }),
        });
        app.createNotice({
          payload: toHex(
            `The account ${metadata.msg_sender} has played ${terms} terms`
          ),
        });
        return "accept";
      default:
        throw new Error(`Unhandled function: ${functionName}`);
    }
  } catch (error) {
    console.error("Error in addAdvanceHandler:", error);
    return "reject";
  }
});

const wallet = createWallet();

app.addAdvanceHandler(wallet.handler);

const router = createRouter({ app });

router.add<{ sender: string }>(
  "wallet/ether/:sender",
  ({ params: { sender } }) => {
    const balance = wallet.etherBalanceOf(sender) ?? BigInt(0);
    return JSON.stringify({
      balance: `${balance.toString()} wei`,
    });
  }
);

router.add<{ token: Address; sender: string }>(
  "wallet/erc20/:token/:sender",
  ({ params: { token, sender } }) => {
    const balance = wallet.erc20BalanceOf(token, sender) ?? BigInt(0);
    return JSON.stringify({
      balance: `${balance.toString()}`,
    });
  }
);

app.addInspectHandler(router.handler);

app.start().catch((error) => {
  console.error("Error starting the app:", error);
  process.exit(1);
});
