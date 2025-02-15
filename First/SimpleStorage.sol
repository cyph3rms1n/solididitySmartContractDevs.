// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage{


    uint256 public favoriteNumber; // uint256 variable type

    // creating a fuction which take a parameter uint256 and set the value of the variable "favoriteNumber"

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }


    /*
        Pure function declares that no state variable will be changed or read.
    */
    
    // Creating a getter function which returns a value of uint256.
    /*
        View function declares that no state will be changed and only can view the variable
    */
    function retrieve() public  view  returns(uint256){
        return favoriteNumber;
    } 

}
