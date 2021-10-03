const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory('TextBox');
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log('Contract deployed to: ', nftContract.address);
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
