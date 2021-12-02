// pragma solidity ^0.4.2;
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
// pragma experimental ABIEncoderV2;

contract Delivery {
    

    struct MenuItem{
        uint id;
        uint restaurantId;
        string name;
        string description;
        uint price;
    }

    struct Restaurant {
        uint id;
        string name;
        string location;
        uint menuCount;
        string imageURL;
    }

    mapping(uint => Restaurant) public restaurants;
    mapping(uint => MenuItem) public menuItens;

    uint public restaurantsCount;
    uint public menuItensCount;


    function addRestaurant (string memory _name,string memory _location, string memory _url) public {
    restaurantsCount++;
    restaurants[restaurantsCount] = Restaurant(restaurantsCount, _name, _location,0,_url);
    }

    function addMenuItem (uint _restaurantId,string memory _name,string memory _description,uint _price) public {
    menuItensCount++;
    restaurants[_restaurantId].menuCount++;
    menuItens[menuItensCount] = MenuItem(menuItensCount, _restaurantId, _name, _description, _price);
    }

    function getRestaurants() public view returns (Restaurant[] memory){
        Restaurant[] memory itens = new Restaurant[](restaurantsCount);
        for(uint i=1;i<=restaurantsCount;i++){
            itens[i-1] = restaurants[i];
        }
        return itens;

    }

    function getRestaurantMenu (uint _restaurantId) public view returns (MenuItem[] memory){
        MenuItem[] memory itens = new MenuItem[](restaurants[_restaurantId].menuCount);
        for(uint i=1;i<=menuItensCount;i++){
            if(menuItens[i].restaurantId == _restaurantId){
                itens[i-1] = menuItens[i];
            }
        }
        return itens;

    }

} 