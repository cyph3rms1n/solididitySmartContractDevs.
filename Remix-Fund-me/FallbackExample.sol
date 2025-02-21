// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FallbackExample {
    uint256 public result;

    // Handle incoming Ether, Used when sending fund to contract without calling the fund function.
    // It is executed when a contract receives Ether without any calldata.
    receive() external payable {
        result = 1;
    }

    // Handle fallback case, When a function that doesn't exist is called.
    // When Ether is sent to a contract but receive() doesn't exist or msg.data is not empty.
    fallback() external payable { 
        result = 2;
    }
}

//      solidity-by-example.org/fallback/
//      Ether is sent to contract
//
//                  send Ether
//                      |
//              msg.data is empty?
//                /           \
//            yes             no
//             |               |
//    receive() exists?     fallback()
//        /        \
//     yes          no
//      |            |
//  receive()     fallback()
