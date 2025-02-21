// Mechanism Of The Contract
/*
    * send funds to the contract.
    * withdraw funds fro the contrat.
    * minimun funding amount in USD
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

// Custom Error
error NotOwner();

contract fundMe {
    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 5e18; // 5e18 = 5 * 1e18 

    address[] public funders; // list of Funders address
    mapping (address funders => uint256 amountFunded) public addressToAmountFunded;

    // The one who deploy this cotract is the owner.
    address public immutable i_owner;
    /* 
        If we declare the owner address as immutable in a Solidity contract,
        we will not be able to transfer ownership to another address after the contract has been deployed.
    */


    // Constructor executes automatically when the contract is depolyed.
    constructor() {
        i_owner = msg.sender;
    }
    
    function fund() public  payable {
        // Functionality of this function
        /*
            * Allow users to send fund.
            * Minimum amount should be 5 USD
        */

        // Conversion of msg.value (in Wei) to USD using getConversionRate() function.
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enough ETH"); // Like an if - else operation
        // revert: undo the prior operation if the transection fails (condition didn't meet) and returns the remaining gas fees.
        funders.push(msg.sender);
        // Keeps the track of funders who funds this contract.
        addressToAmountFunded[msg.sender] +=  msg.value;
    }

    function withdraw() public onlyOwner {
        
        // Using for loop to reset the funded amount after the withdraw function executes
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex ++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // Reseting the array
        funders = new address[] (0);

        // Actually withdrawing teh funds
        /*
            There are three ways to withdraw the funds.
            1. transfer
            2. send
            3. call
        */

        // // transfer (2300 gas, throws error)
        // payable(msg.sender).transfer(address(this).balance); // msg.sender = address and payable(msg.sender) = payable adress

        // // send (2300 gas, returns bool)
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Transection Failed");

        // call (forward all gas or set gas, returns bool)
        (bool callSuccess,) = payable(msg.sender).call{value:address(this).balance}("");
        require(callSuccess, "Transection Failed");

    }

    // Special functions that modify the behavior of other functions.
    modifier onlyOwner() {
        require(msg.sender == i_owner, "You are not the owner"); // It will check wheter the person calling the function is owner or not.
        _; // " _; " helps you do other work in the function
    }
   
    // What happens if someone sends this contract ETH withouth calling the fund function.
    
    receive() external payable { 
        fund();
    }

    fallback() external payable { 
        fund();
    }
}
