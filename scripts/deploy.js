async function main() {
    const OnchainMetadataNFT = await ethers.getContractFactory("OnchainMetadataNFT")
  
    const nft = await OnchainMetadataNFT.deploy()
    await nft.deployed()
    console.log("Contract deployed to address:", nft.address)
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error)
      process.exit(1)
    })
  