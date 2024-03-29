const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory('TextBox');
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log('Contract deployed to: ', nftContract.address);

  let txn = await nftContract.makeAnEpicNFT();
  await txn.wait();

  // Mint another NFT for fun.
  txn = await nftContract.makeAnEpicNFT();
  // Wait for it to be mined.
  await txn.wait();

  console.log('Done mining NFT\'s!');
};

const runMain = async () => {
  try {
    await main();
    process.exit();
  } catch (e) {
    console.log('Error: ', e);
    process.exit(1);
  }
};

runMain();
