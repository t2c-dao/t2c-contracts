const hre = require("hardhat");

async function main() {


    const T2C = await hre.ethers.getContractFactory("T2C");
    const t2c = await T2C.deploy();



    await t2c.deployed();

    const t2cAddress = t2c.address;  // 0x70931a5d040173195FaEE368F2CF2a2A3921b090


    console.log("----------------------------------------------------------------------------------------------------------------------------------------------------")
    console.log(`Exchange has been deployed to the address : ${t2cAddress}`);  // 0x70931a5d040173195FaEE368F2CF2a2A3921b090
    console.log("----------------------------------------------------------------------------------------------------------------------------------------------------")
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
