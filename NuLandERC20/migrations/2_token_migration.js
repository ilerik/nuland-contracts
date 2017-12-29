var NuLandToken = artifacts.require("./NuLandToken.sol");

module.exports = function(deployer) {
  deployer.deploy(NuLandToken);
};
