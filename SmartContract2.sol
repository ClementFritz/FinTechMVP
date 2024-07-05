// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChainFinance {
    address public buyer;
    address public supplier;
    uint256 public orderAmount;
    bool public orderReceived;
    bool public fundsTransferred;
    bool public supplierConfirmed;
    bool public disputeRaised;
    uint256 public partialPaymentAmount;

    event OrderConfirmed();
    event PaymentTransferred(address to, uint256 amount);
    event DisputeRaised();
    event DisputeResolved();
    event OrderCancelled();
    event SupplierConfirmed();
    event PartialPaymentMade(uint256 amount);
    
    constructor(address _supplier, uint256 _orderAmount) {
        buyer = msg.sender;
        supplier = _supplier;
        orderAmount = _orderAmount;
        orderReceived = false;
        fundsTransferred = false;
        supplierConfirmed = false;
        disputeRaised = false;
        partialPaymentAmount = 0;
    }
    
    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only the buyer can call this function.");
        _;
    }
    
    modifier onlySupplier() {
        require(msg.sender == supplier, "Only the supplier can call this function.");
        _;
    }
    
    function confirmOrder() public onlyBuyer {
        require(supplierConfirmed, "Supplier must confirm the order first.");
        require(!disputeRaised, "Cannot confirm order while a dispute is raised.");
        orderReceived = true;
        emit OrderConfirmed();
    }
    
    function confirmSupplier() public onlySupplier {
        supplierConfirmed = true;
        emit SupplierConfirmed();
    }

    function raiseDispute() public {
        require(msg.sender == buyer || msg.sender == supplier, "Only buyer or supplier can raise a dispute.");
        disputeRaised = true;
        emit DisputeRaised();
    }
    
    function resolveDispute() public onlyBuyer {
        require(disputeRaised, "No dispute to resolve.");
        disputeRaised = false;
        emit DisputeResolved();
    }
    
    function transferPayment() public onlyBuyer {
        require(orderReceived, "Order must be confirmed before payment.");
        require(!fundsTransferred, "Payment already transferred.");
        require(!disputeRaised, "Cannot transfer payment while a dispute is raised.");
        fundsTransferred = true;
        payable(supplier).transfer(orderAmount);
        emit PaymentTransferred(supplier, orderAmount);
    }

    function makePartialPayment(uint256 _amount) public onlyBuyer payable {
        require(_amount <= orderAmount, "Partial payment exceeds order amount.");
        require(msg.value == _amount, "Incorrect payment amount.");
        require(!fundsTransferred, "Payment already transferred.");
        partialPaymentAmount += _amount;
        payable(supplier).transfer(_amount);
        emit PartialPaymentMade(_amount);
    }
    
    function depositFunds() public onlyBuyer payable {
        require(!supplierConfirmed, "Supplier must not confirm the order before depositing funds.");
        require(msg.value == orderAmount, "Incorrect order amount.");
    }
    
    function cancelOrder() public onlyBuyer {
    require(!orderReceived, "Cannot cancel order after it is received.");
    require(!fundsTransferred, "Cannot cancel order after payment is transferred.");
    
    // Send remaining funds back to buyer
    (bool success,) = payable(buyer).call{value: address(this).balance}("");
    require(success, "Funds transfer failed");
    
    emit OrderCancelled();
}
}

