// Mechanism Of The Contract
/*
    * send funds to the contract.
    * withdraw funds fro the contrat.
    * minimun funding amount in USD
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
contract fundMe {

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
        require(getConversionRate(msg.value) >= minimumUsd, "didn't send enough ETH"); // Like an if - else operation
        // revert: undo the prior operation if the transection fails (condition didn't meet) and returns the remaining gas fees.
        funders.push(msg.sender);
        // Keeps the track of funders who funds this contract.
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function getPrice() public view returns(uint256){
        // Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI: ✅

        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 price,, ,  ) = priceFeed.latestRoundData();
        // Price of ETH in terms of USD

        /* 
            It multiplies the price by 1e10 to adjust for decimals 
            (Chainlink returns price with 8 decimals, and we're converting to 18 decimals for Wei precision).
            It casts the result to uint256 and returns it.
        */
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethPriceInUSD = (ethPrice * ethAmount) / 1e18;
        return ethPriceInUSD;
    }

    function getVersion() public view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}
