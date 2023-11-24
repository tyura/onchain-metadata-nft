require("dotenv").config();

const { API_URL, PRIVATE_KEY, PUBLIC_KEY, CONTRACT_ADDRESS } = process.env;
const { createAlchemyWeb3 } = require("@alch/alchemy-web3");
const web3 = createAlchemyWeb3(API_URL);

const contract = require("../artifacts/contracts/OnchainMetadataNFT.sol/OnchainMetadataNFT.json");
const nftContract = new web3.eth.Contract(contract.abi, CONTRACT_ADDRESS);

async function mintToken(to, metadata) {
  const nonce = await web3.eth.getTransactionCount(PUBLIC_KEY, "latest");

  const tx = {
    from: PUBLIC_KEY,
    to: CONTRACT_ADDRESS,
    nonce: nonce,
    gas: 2000000,
    data: nftContract.methods.mintToken(to, metadata).encodeABI(),
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

mintToken("{{toAddress}}", {
  name: "Vegeta",
  description: "Saiyan Prince",
  attributes: {
    packId: "KMY_001",
    cardBaseId: "KMY_001_R001",
    indivisualId: 10003202,
    frameId: "R01",
    isVoiceOpened: false,
    isUsed: false,
    firstUser: "Freezer",
    usedCount: 0,
    altIllustId: 2,
    cost: 7,
    offensivePower: 7,
    hp: 7,
    skill1: "guard",
    skill2: "speed",
    skill3: "intelligence",
    skill4: "-",
    lines: "Big bang attack",
    illustrator: "Akira Toriyama",
    cv: "Ryo Horikawa",
  },
  image: "{{imageUrl}}",
});
