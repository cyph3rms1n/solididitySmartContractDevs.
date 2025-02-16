// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage{


    uint256  myFavoriteNumber; // uint256 variable type

    // creating a fuction which take a parameter uint256 and set the value of the variable "favoriteNumber"
    function store(uint256 _favoriteNumber) public {
        myFavoriteNumber = _favoriteNumber;
    }
    // View and Pure
    function retrieve() public  view  returns(uint256){
        return myFavoriteNumber;
    } 


    // Creatign a user-defined variable : Struct
    // same as : uint256[] listOfFavouriteNumbers;
    /*
        * First: we created a variable name "Person"
        * Second: we created an array of the variable "person" and name the variable as "listOfPerson"
        * Third: we created a function called "addPerson" to add the value to the array "listOfPerson"
    */
    struct Person{
        uint256 favouriteNumber;
        string name;
    }

    Person[] public listOfPeoples; // holds null as a default value and also this array is a dynamic array

    // Mapping 
    mapping (string => uint256) public nameToFavoriteNumber;

    function addPerson(string memory _name, uint256 _favouriteNumber) public {
        listOfPeoples.push( Person(_favouriteNumber,_name));
        nameToFavoriteNumber[_name] = _favouriteNumber;
    }
    // Person public sam = Person(99,"sam");
    // Person public noah = Person(65, "noah");
    // Person public ryuk = Person({favouriteNumber: 32, name : "ryuk"});
    // Person public mykex = Person({favouriteNumber: 7, name : "mykex"});

    
}
