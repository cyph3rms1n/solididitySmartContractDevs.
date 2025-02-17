// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


// Importing different contract in this contract
// Named Import helps us to import only the contract we required 
// An import contract without name is a default contract and a contract can have only one default contract

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public  listOfSimpleStorageContracts; // int[] public arr;

    function createSimpleStorageContract() public {
        SimpleStorage newSimpleStorageContract = new SimpleStorage();// int x = new x;
        listOfSimpleStorageContracts.push(newSimpleStorageContract);
    }

    function sfstore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex]; // mySimpleStorage = {0,1,2,3,4,5,6,7,...} :- array holding index 
        mySimpleStorage.store(_newSimpleStorageNumber);   // mySimpleStorgae = {121, 222, 121,2232 ,112312, 221222,334444} :- same array holding the value on the index
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        return listOfSimpleStorageContracts[_simpleStorageIndex].retrieve();
    }
}
