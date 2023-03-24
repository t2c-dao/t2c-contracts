// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {


  const CareToken = await hre.ethers.getContractFactory("CARE");
  const care = await CareToken.deploy("Care Token", "CARE");

  console.log("Deploying the CARE Token contract!!!!!")

  await care.deployed();

  const tokenAddress = care.address;  // 0x99b78056472cd63f5438d74666F0189a7Cd83991

  console.log("----------------------------------------------------------------------------------------------------------------------------------------------------")
  console.log(`CARE token has been deployed to the address : ${tokenAddress}`);  // 0x99b78056472cd63f5438d74666F0189a7Cd83991
  console.log("----------------------------------------------------------------------------------------------------------------------------------------------------")




  const Exchange = await hre.ethers.getContractFactory("Exchange");
  const exchange = await Exchange.deploy(care.address);



  await exchange.deployed();

  const exchangeAddress = exchange.address;  // 0x70931a5d040173195FaEE368F2CF2a2A3921b090


  console.log("----------------------------------------------------------------------------------------------------------------------------------------------------")
  console.log(`Exchange has been deployed to the address : ${exchangeAddress}`);  // 0x70931a5d040173195FaEE368F2CF2a2A3921b090
  console.log("----------------------------------------------------------------------------------------------------------------------------------------------------")
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
