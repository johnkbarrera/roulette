// Allows us to use ES6 in our migrations and tests.
require('babel-register')

module.exports = {
  networks: {
    development: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*' // Match any network id
    },
    ropsten:  {
      network_id: 3,
      host: "127.0.0.1",
      port:  8545,
      gas:   200000
    },
    rinkeby: {
      host: "localhost", // Connect to geth on the specified
      port: 8545,
      //from: "0x6a6401AEb4a3beb93820904E761b0d86364bb39E", // default address to use for any transaction Truffle makes during migrations
      network_id: 4,
      gas: 200000 // Gas limit used for deploys
    }
  }
}
