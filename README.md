# FinTech: Business Models and Application
*2nd Assignment - Development of a Minimum Viable Product*

**Student: Clément Fritz, 522486cf**

This GitHub repository contains the code for the smart contracts of "Smart Finance Technologies". The contract facilitates automated payment processing upon order confirmation, enhancing the efficiency and security of supply chain finance operations. 

## File Overview
This repository contains mutliple files:
1. README.md: explanation of code and integration
2. SmartContract1.sol: most basic smart contract version - named `SupplyChainFinance_V1`
3. SmartContract2.sol: smart contract with additional optional features - named `SupplyChainFinance_V2`

All code files are explained below.

## SmartContract1
### Contract Overview

The `SupplyChainFinance_V1` contract automates the transfer of funds from the buyer to the supplier once the order is confirmed.

### Key Features

- **Order Confirmation**: The buyer confirms the receipt of goods or services.
- **Automated Payment Transfer**: Funds are transferred to the supplier upon order confirmation.
- **Event Logging**: Important actions like order confirmation and payment transfer are logged.

### Contract Variables

- `address public buyer`: The address of the buyer.
- `address public supplier`: The address of the supplier.
  - Example address of Ethereum Account: `0xb794f5ea0ba39494ce839613fffba74279579268` 
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

### Contract Overview

The `SupplyChainFinance_V2` contract automates the transfer of funds from the buyer to the supplier once the order is confirmed, with additional features for dispute handling, partial payments, and multi-party confirmation.

### Key Features

- **Order Confirmation**: The buyer confirms the receipt of goods or services.
- **Supplier Confirmation**: The supplier confirms the order before the buyer can deposit funds.
- **Automated Payment Transfer**: Funds are transferred to the supplier upon order confirmation.
- **Partial Payments**: Supports partial payments for large orders.
- **Dispute Handling**: Allows either party to raise and resolve disputes.
- **Order Cancellation**: Allows the buyer to cancel the order under certain conditions.
- **Event Logging**: Important actions like order confirmation, payment transfer, dispute handling, and partial payments are logged.

### Contract Variables

- `address public buyer`: The address of the buyer.
- `address public supplier`: The address of the supplier.
  - Example address of Ethereum Account: `0xb794f5ea0ba39494ce839613fffba74279579268`
- `uint256 public orderAmount`: The amount to be transferred, specified in the smallest unit of the currency (e.g., wei for ETH).
- `bool public orderReceived`: Indicates if the order has been received.
- `bool public fundsTransferred`: Indicates if the funds have been transferred.
- `bool public supplierConfirmed`: Indicates if the supplier has confirmed the order.
- `bool public disputeRaised`: Indicates if a dispute has been raised.
- `uint256 public partialPaymentAmount`: Tracks the total partial payment amount made.

### Events

- `event OrderConfirmed()`: Emitted when the order is confirmed by the buyer.
- `event SupplierConfirmed()`: Emitted when the supplier confirms the order.
- `event PaymentTransferred(address to, uint256 amount)`: Emitted when the payment is transferred to the supplier.
- `event DisputeRaised()`: Emitted when a dispute is raised by either party.
- `event DisputeResolved()`: Emitted when a dispute is resolved by the buyer.
- `event OrderCancelled()`: Emitted when the order is cancelled by the buyer.
- `event PartialPaymentMade(uint256 amount)`: Emitted when a partial payment is made by the buyer.

### Functions

#### `constructor(address _supplier, uint256 _orderAmount)`

Initializes the contract with the supplier's address and the order amount. The buyer is set to the contract deployer.

#### `confirmOrder() public`

Allows the buyer to confirm the order after the supplier has confirmed it. Emits the `OrderConfirmed` event.

#### `confirmSupplier() public`

Allows the supplier to confirm the order. Emits the `SupplierConfirmed` event.

#### `raiseDispute() public`

Allows either the buyer or supplier to raise a dispute. Emits the `DisputeRaised` event.

#### `resolveDispute() public`

Allows the buyer to resolve the dispute. Emits the `DisputeResolved` event.

#### `transferPayment() public`

Transfers the order amount to the supplier if the order has been confirmed and funds have not been transferred yet. Emits the `PaymentTransferred` event.

#### `makePartialPayment(uint256 _amount) public payable`

Allows the buyer to make partial payments toward the order amount. Emits the `PartialPaymentMade` event.

#### `depositFunds() public payable`

Allows the buyer to deposit the exact order amount in the contract. The amount must match the specified `orderAmount`.

#### `cancelOrder() public`

Allows the buyer to cancel the order before it is confirmed or funds are transferred. Sends any remaining funds back to the buyer and emits the OrderCancelled event.

### Usage Instructions

1. **Deploy the Contract**
   - Deploy the contract with the supplier's address and the order amount (in smallest currency units).
   ```solidity
   SupplyChainFinance(supplierAddress, orderAmount);
2. **Supplier Confirmation**
   - The supplier confirms the order
   ```solidity
   contract.confirmSupplier();
    ```
3. **Deposit Funds**
   - The buyer deposits the required funds into the contract.
   ```solidity
   contract.depositFunds({ value: orderAmount });
    ```
4. **Confirm Order**
   - The buyer confirms the receipt of goods or services.
   ```solidity
   contract.confirmOrder();
    ``` 
5. **Transfer Payment**
   - After order confirmation, the buyer (or another authorized entity) transfers the payment to the supplier.
   ```solidity
   contract.transferPayment();
    ```
6. **Raise Dispute** (optional)
   - If there is an issue, either party can raise a dispute.
    ```solidity
   contract.transferPayment();
    ```
7. **Resolve Dispute** (optional)
   - The buyer can resolve the dispute
    ```solidity
   contract.resolveDispute();
    ```
8. **Make Partial Payments** (optional)
   - The buyer can make partial payments towards the order amount.
    ```solidity
   contract.makePartialPayment(partialAmount, { value: partialAmount });
    ```
9. **Cancel Order** (optional)
   - The buyer can cancel the order before it is confirmed or funds are transferred. Any remaining funds are sent back to the buyer.
    ```solidity
   contract.cancelOrder();
    ```

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
