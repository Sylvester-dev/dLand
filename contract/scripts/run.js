const hre = require("hardhat");

async function main() {

  const Land = await hre.ethers.getContractFactory("dLand");
  const land = await Land.deploy("UrMomHouse","UMH",ethers.utils.parseEther("0.1"));

  await land.deployed();

  console.log("Land deployed to:", land.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
