// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleSmartWallet is Ownable {
    event Deposited(address indexed sender, uint256 amount);
    event Withdrawn(address indexed owner, uint256 amount);

    constructor() Ownable(msg.sender) {
        // The initial owner is set to the address deploying the contract
    }

    // Explicit deposit function
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        emit Deposited(msg.sender, msg.value);
    }

    // Accept direct transfers (no data)
    receive() external payable {
        emit Deposited(msg.sender, msg.value);
    }

    // Accept direct transfers (with data)
    fallback() external payable {
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) external onlyOwner {
        require(address(this).balance >= _amount, "Insufficient balance");
        payable(owner()).transfer(_amount);
        emit Withdrawn(owner(), _amount);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
