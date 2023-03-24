const hre = require("hardhat");

async function main() {


    const WCARE = await hre.ethers.getContractFactory("WCARE");
    const WCare = await WCARE.deploy();



    await WCare.deployed();

    const WCareAddress = WCare.address;  // 0x44d46A41e866c6aF99115e4805FfbE5a2b6d2A4b


    console.log("----------------------------------------------------------------------------------------------------------------------------------------------------")
    console.log(`Exchange has been deployed to the address : ${WCareAddress}`);  // 0x44d46A41e866c6aF99115e4805FfbE5a2b6d2A4b
    console.log("----------------------------------------------------------------------------------------------------------------------------------------------------")
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
