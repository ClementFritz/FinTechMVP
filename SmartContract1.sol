// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChainFinance {
    address public buyer;
    address public supplier;
    uint256 public orderAmount;
    bool public orderReceived;
    bool public fundsTransferred;
    
    event OrderConfirmed();
    event PaymentTransferred(address to, uint256 amount);
    
    constructor(address _supplier, uint256 _orderAmount) {
        buyer = msg.sender;
        supplier = _supplier;
        orderAmount = _orderAmount;
        orderReceived = false;
        fundsTransferred = false;
    }
    
    function confirmOrder() public{
        require(msg.sender == buyer, "Only the buyer can confirm the order.");
        orderReceived = true;
        emit OrderConfirmed();
    }
    
    function transferPayment() public {
        require(orderReceived, "Order must be confirmed before payment.");
        require(!fundsTransferred, "Payment already transferred.");
        fundsTransferred = true;
        payable(supplier).transfer(orderAmount);
        emit PaymentTransferred(supplier, orderAmount);
    }
    
    function depositFunds() public payable {
        require(msg.sender == buyer, "Only the buyer can deposit funds.");
        require(msg.value == orderAmount, "Incorrect order amount.");
    }
}
