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

        if (typeof terms !== "number" || terms < 1) {
          throw new Error("Invalid terms: must be a positive integer");
        }

        let e = 0;

        function factorial(n: number): number {
          if (n === 0 || n === 1) {
            return 1;
          }
          return n * factorial(n - 1);
        }

        for (let i = 0; i < terms; i++) {
          e += 1 / factorial(i);
        }

        if (e < 1) {
          throw new Error("Calculated value of e is less than 1");
        }

        app.createVoucher({
          destination: "0x92C6bcA388E99d6B304f1Af3c3Cd749Ff0b591e2",
          value: "0x0000000000000000000000000000000000000000000000000000000000000001",
          payload: encodeFunctionData({
            abi: parseAbi(["function mint(address,uint256)"]),
            functionName: "mint",
            args: [
              metadata.msg_sender,
              wallet.erc20BalanceOf(
                "0x92C6bcA388E99d6B304f1Af3c3Cd749Ff0b591e2",
                metadata.msg_sender
              ),
            ],
          }),
        });

        app.createNotice({
          payload: toHex(
            `The account ${metadata.msg_sender} calculated e as ${e.toFixed(
              5
            )} using ${terms} terms.`
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
