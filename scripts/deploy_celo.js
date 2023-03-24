const hre = require("hardhat");

async function main() {


    const T2C = await hre.ethers.getContractFactory("T2C");
    const t2c = await T2C.deploy();



    await t2c.deployed();

    const t2cAddress = t2c.address;  // 0x44d46A41e866c6aF99115e4805FfbE5a2b6d2A4b


    console.log("----------------------------------------------------------------------------------------------------------------------------------------------------")
    console.log(`T2C has been deployed to the address : ${t2cAddress}`);  // 0x44d46A41e866c6aF99115e4805FfbE5a2b6d2A4b
    console.log("----------------------------------------------------------------------------------------------------------------------------------------------------")
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
