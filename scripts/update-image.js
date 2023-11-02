require("dotenv").config();

const { API_URL, PRIVATE_KEY, PUBLIC_KEY, CONTRACT_ADDRESS } = process.env;
const { createAlchemyWeb3 } = require("@alch/alchemy-web3");
const web3 = createAlchemyWeb3(API_URL);

const contract = require("../artifacts/contracts/OnchainMetadataNFT.sol/OnchainMetadataNFT.json");
console.log(JSON.stringify(contract.abi));
const nftContract = new web3.eth.Contract(contract.abi, CONTRACT_ADDRESS);

async function updateImage(tokenId, image) {
  const nonce = await web3.eth.getTransactionCount(PUBLIC_KEY, "latest");

  const tx = {
    from: PUBLIC_KEY,
    to: CONTRACT_ADDRESS,
    nonce: nonce,
    gas: 500000,
    data: nftContract.methods.updateImage(tokenId, image).encodeABI(),
  };

  const signPromise = web3.eth.accounts.signTransaction(tx, PRIVATE_KEY);
  signPromise
    .then((signedTx) => {
      web3.eth.sendSignedTransaction(
        signedTx.rawTransaction,
        function (err, hash) {
          if (!err) {
            console.log(
              "The hash of your transaction is: ",
              hash,
              "\nCheck Alchemy's Mempool to view the status of your transaction!"
            );
          } else {
            console.log(
              "Something went wrong when submitting your transaction:",
              err
            );
          }
        }
      );
    })
    .catch((err) => {
      console.log("Promise failed:", err);
    });
}

updateImage(
  0,
  "https://arweave.net/YTh-mxcO_qffI8DB9RDIjI38YYlLe1Qj8ufmelY9Wbo"
);
