const hre = require("hardhat");

async function main() {
  const MyToken = await hre.ethers.getContractFactory("VoroslandRuble");
  const myToken = await MyToken.deploy();
  
  // Wait for the contract to be mined
  await myToken.waitForDeployment();

  console.log("Ocean token deployed: ", await myToken.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});