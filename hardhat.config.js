require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

module.exports = {
  solidity: "0.8.10",
  networks: {
    hardhat: {
      chainId: 1337,
    },
    mumbai: {
      url: process.env.NEXT_PUBLIC_ALCHEMY_KEY,
      accounts: [
        `0x1a220a8b6c0c024deaebe717b7bd3440e283a17f1280a0683000dec9dd6ca356`,
      ],
    },
    // polygon: {
    //   url: "https://polygon-rpc.com/",
    //   accounts: [process.env.pk]
    // }
  },
};
