require("dotenv").config();

const {
  Contract,
  JsonRpcProvider,
  Wallet,
  parseUnits,
} = require("ethers");

async function main() {
  const {
    RPC_URL,
    EXPECTED_CHAIN_ID,
    ORACLE_ADDRESS,
    ORACLE_OWNER_PRIVATE_KEY,
    COINGECKO_API_KEY,
  } = process.env;

  if (
    !RPC_URL ||
    !EXPECTED_CHAIN_ID ||
    !ORACLE_ADDRESS ||
    !ORACLE_OWNER_PRIVATE_KEY ||
    !COINGECKO_API_KEY
  ) {
    throw new Error("Missing required .env setting");
  }

  // 1. Fetch ETH/USD and the source update timestamp.
  const url =
    "https://api.coingecko.com/api/v3/simple/price" +
    "?ids=ethereum&vs_currencies=usd" +
    "&include_last_updated_at=true";

  const response = await fetch(url, {
    headers: {
      "x-cg-demo-api-key": COINGECKO_API_KEY,
    },
  });

  if (!response.ok) {
    throw new Error(`Price API failed: ${response.status}`);
  }

  const data = await response.json();
  const priceUsd = data?.ethereum?.usd;
  const sourceTime = data?.ethereum?.last_updated_at;

  // 2. Validate the API response.
  if (
    typeof priceUsd !== "number" ||
    !Number.isFinite(priceUsd) ||
    priceUsd <= 0
  ) {
    throw new Error("Invalid ETH/USD price");
  }

  if (!Number.isSafeInteger(sourceTime) || sourceTime <= 0) {
    throw new Error("Invalid source timestamp");
  }

  const now = Math.floor(Date.now() / 1000);

  if (sourceTime > now + 30 || now - sourceTime > 300) {
    throw new Error("Source price is too old or timestamp is invalid");
  }

  // 3. Scale the price to 8 decimal places.
  const scaledPrice = parseUnits(priceUsd.toFixed(8), 8);

  // 4. Connect to the blockchain and verify the network.
  const provider = new JsonRpcProvider(RPC_URL);
  const network = await provider.getNetwork();

  if (network.chainId !== BigInt(EXPECTED_CHAIN_ID)) {
    throw new Error(`Unexpected chain ID: ${network.chainId}`);
  }

  const wallet = new Wallet(ORACLE_OWNER_PRIVATE_KEY, provider);

  const oracle = new Contract(
    ORACLE_ADDRESS,
    [
      "function owner() view returns (address)",
      "function setPrice(int256 newPrice, uint256 sourceUpdatedAt)",
    ],
    wallet
  );

  // 5. Verify that this wallet is authorized to publish.
  const owner = await oracle.owner();

  if (owner.toLowerCase() !== wallet.address.toLowerCase()) {
    throw new Error("Publisher wallet is not the oracle owner");
  }

  // 6. Publish the price and source timestamp on-chain.
  console.log("ETH/USD from API:", priceUsd);
  console.log("Source timestamp:", sourceTime);
  console.log("Scaled price:", scaledPrice.toString());

  const tx = await oracle.setPrice(
    scaledPrice,
    BigInt(sourceTime)
  );

  console.log("Transaction submitted:", tx.hash);

  const receipt = await tx.wait();

  console.log("Transaction confirmed in block:", receipt.blockNumber);
}

main().catch((error) => {
  console.error("Oracle update failed:", error.message);
  process.exitCode = 1;
});