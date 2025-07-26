// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.9; // stating the version

contract SimpleStorage{
    uint256 public myfavoriteNumber; // declaring the state variable

   // uint256[] listoffavoriteNumbers; //0
   struct Person{
        uint256 favoriteNumber;
        string name;
        
   }
   //Dynamic array
   Person[] public listOfPeople; //[]
   

   mapping(string => uint256) public nameToFavoriteNumber; //(key => value) 
  

    function store (uint256 _favoriteNumber) public { 
        myfavoriteNumber = _favoriteNumber; // assigning the value to the state variable
        
    }

    function retrieve() public view returns(uint256){ 
    
        return myfavoriteNumber; // returning the value of the state variable
    }

    function addPerson(string memory _name, uint256 _favoriteNumber)public {
        listOfPeople.push( Person(_favoriteNumber, _name) );
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
    

