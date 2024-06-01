import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();
  const DegenStore = await ethers.deployContract("DegenStore");

  await DegenStore.waitForDeployment();

  console.log(
    `DegenStore deployed to ${DegenStore.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
