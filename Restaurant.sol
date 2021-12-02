pragma solidity ^0.4.2;

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
    }

    mapping(uint => Restaurant) public restaurants;
    mapping(uint => MenuItem) public menuItens;

    uint public restaurantsCount;
    uint public menuItensCount;


    function addRestaurant (string _name,string _location) public {
    restaurantsCount++;
    restaurants[restaurantsCount] = Restaurant(restaurantsCount, _name, _location,0);
    }

    function addMenuItem (uint _restaurantId,string _name,string _description,uint _price) public {
    menuItensCount++;
    restaurants[_restaurantId].menuCount++;
    menuItens[menuItensCount] = MenuItem(menuItensCount, _restaurantId, _name, _description, _price);
    }
} 