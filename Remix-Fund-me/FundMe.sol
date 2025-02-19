// Mechanism Of The Contract
/*
    * send funds to the contract.
    * withdraw funds fro the contrat.
    * minimun funding amount in USD
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract fundMe {

    uint256 minimumUsd = 5;
    function fund() public  payable {
        // Functionality of this function
        /*
            * Allow users to send fund.
            * Minimum amount should be 5 USD
        */

        require(msg.value >= minimumUsd, " not enough balance");
    }
}
