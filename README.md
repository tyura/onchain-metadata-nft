# onchain-metadata-nft

This is a sample project for minting NFTs with on-chain metadata.

## Usage

Prepare a .env file following a .env.example.

Compile the Solidity program, and it will generate artifacts.
```zsh
npx hardhat compile
```

Deploy the NFT contract, and you can obtain the contract address in the console.
```zsh
npx hardhat --network goerli run scripts/deploy.js
```

Mint an NFT.
Adjust the parameters of the mintToken function within the script as you like.
```zsh
node scripts/mint-nft.js
```

Update the image of NFT metadata.
Adjust the parameters of the updateImage function within the script as you like.
```zsh
node scripts/update-image.js
```

Verify the contract.
```zsh
npx hardhat verify --network goerli {{ CONTRACT_ADDRESS }}
```
