// Price Converter Library

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


library PriceConverter {
     function getPrice() internal  view returns(uint256){
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

    function getConversionRate(uint256 ethAmount) internal  view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethPriceInUSD = (ethPrice * ethAmount) / 1e18;
        return ethPriceInUSD;
    }

    function getVersion() internal  view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}
