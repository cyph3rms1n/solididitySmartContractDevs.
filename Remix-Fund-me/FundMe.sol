// Mechanism Of The Contract
/*
    * send funds to the contract.
    * withdraw funds fro the contrat.
    * minimun funding amount in USD
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract fundMe {
    using PriceConverter for uint256;
    uint256 minimumUsd = 5e18; // 5e18 = 5 * 1e18 

    address[] public funders; // list of Funders address
    mapping (address funders => uint256 amountFunded) public addressToAmountFunded;
    
    function fund() public  payable {
        // Functionality of this function
        /*
            * Allow users to send fund.
            * Minimum amount should be 5 USD
        */

        // Conversion of msg.value (in Wei) to USD using getConversionRate() function.
        require(msg.value.getConversionRate() >= minimumUsd, "didn't send enough ETH"); // Like an if - else operation
        // revert: undo the prior operation if the transection fails (condition didn't meet) and returns the remaining gas fees.
        funders.push(msg.sender);
        // Keeps the track of funders who funds this contract.
        addressToAmountFunded[msg.sender] +=  msg.value;
    }

    function withdraw() public {
        // Using for loop to reset the funded amount after the withdraw function executes

        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex ++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
    }

   
}
