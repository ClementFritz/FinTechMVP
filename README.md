# FinTech: Business Models and Application
*2nd Assignment - Development of a Minimum Viable Product*

**Student: Clément Fritz, 522486cf**

This GitHub repository contains the code for the smart contracts of "Smart Finance Technologies". The contract facilitates automated payment processing upon order confirmation, enhancing the efficiency and security of supply chain finance operations. 

## File Overview
This repository contains mutliple files:
1. README.md: explanation of code and integration
2. SmartContract1.sol: most basic smart contract version

All code files are explained below.

## SmartContract1
### Contract Overview

The `SupplyChainFinance` contract automates the transfer of funds from the buyer to the supplier once the order is confirmed.

### Key Features

- **Order Confirmation**: The buyer confirms the receipt of goods or services.
- **Automated Payment Transfer**: Funds are transferred to the supplier upon order confirmation.
- **Event Logging**: Important actions like order confirmation and payment transfer are logged.

### Contract Variables

- `address public buyer`: The address of the buyer.
- `address public supplier`: The address of the supplier.
      - Example Adress: `0xb794f5ea0ba39494ce839613fffba74279579268` 
- `uint256 public orderAmount`: The amount to be transferred, specified in the smallest unit of the currency (e.g., wei for ETH).
- `bool public orderReceived`: Indicates if the order has been received.
- `bool public fundsTransferred`: Indicates if the funds have been transferred.

### Events

- `event OrderConfirmed()`: Emitted when the order is confirmed by the buyer.
- `event PaymentTransferred(address to, uint256 amount)`: Emitted when the payment is transferred to the supplier.

### Functions

#### `constructor(address _supplier, uint256 _orderAmount)`

Initializes the contract with the supplier's address and the order amount. The buyer is set to the contract deployer.

#### `confirmOrder() public`

Allows the buyer to confirm the order. Emits the `OrderConfirmed` event.

#### `transferPayment() public`

Transfers the order amount to the supplier if the order has been confirmed and funds have not been transferred yet. Emits the `PaymentTransferred` event.

#### `depositFunds() public payable`

Allows the buyer to deposit the exact order amount in the contract. The amount must match the specified `orderAmount`.

### Usage Instructions

1. **Deploy the Contract**
   - Deploy the contract with the supplier's address and the order amount (in smallest currency units).
   ```solidity
   SupplyChainFinance(supplierAddress, orderAmount);
    ```
2. **Deposit Funds**
   - The buyer deposits the required funds into the contract.
   ```solidity
   contract.depositFunds({ value: orderAmount });
    ```
3. **Confirm Order**
   - The buyer confirms the receipt of goods or services.
   ```solidity
   contract.confirmOrder();
    ``` 
4. **Transfer Payment**
   - After order confirmation, the buyer (or another authorized entity) transfers the payment to the supplier.
   ```solidity
   contract.transferPayment();
    ``` 

## SmartContract2

## Further Steps
Please note that additional steps are required to integrate the contract into company systems.

### Additional Steps for Full Integration

While the repository provides the smart contract code, additional steps are necessary for full integration into a company's system.

1. **Set Up Development Environment**:
   - Ensure the availability of necessary development tools installed, including Node.js, Truffle, and Ganache.

2. **Modify Contract Parameters**:
   - Update the constructor parameters as needed (supplier address and order amount).

3. **Compile and Deploy the Contract**:
   - Use Remix IDE or Truffle to compile and deploy the contract

4. **Set Up Front-End Application**:
   - Develop a front-end application to interact with the smart contract. Use web3.js or ethers.js for blockchain interactions.
   - Ensure the application allows users (buyers and suppliers) to confirm orders and manage payments.

5. **Integrate with Existing Systems**:
   - Connect the smart contract with existing ERP or supply chain management systems.
   - Implement APIs or middleware to facilitate communication between the smart contract and internal systems.

6. **Testing and Security Audits**:
   - Conduct thorough testing on a testnet environment to ensure all functionalities work as expected.
   - Perform security audits to identify and mitigate any vulnerabilities in the smart contract.

7. **Deployment on Mainnet**:
   - After successful testing and audits, deploy the contract on the Ethereum Mainnet.
   - Update front-end application and systems to interact with the Mainnet deployment.

8. **Monitoring and Maintenance**:
   - Implement monitoring tools to track contract interactions and performance.
   - Regularly update and maintain the smart contract and associated applications to address any issues and incorporate improvements.
