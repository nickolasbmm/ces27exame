// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Delivery {
    

    struct MenuItem{
        uint id;
        uint restaurantId;
        string name;
        string description;
        uint price;
        string imageURL;
        bool exists;
    }

    struct Restaurant {
        uint id;
        string name;
        string location;
        string description;
        string imageURL;
        uint menuCount;
        bool exists;
    }

    mapping(uint => Restaurant) public restaurants;
    mapping(uint => MenuItem) public menuItens;

    uint public restaurantsCount = 0; //counts total restaurants 
    uint public menuItensCount = 0; // counts total menuItens
    uint public restaurantsCountExists = 0; //counts only restaurants that exist (i.e. not deleted)


    function addRestaurant (string memory _name,string memory _location, string memory _description,string memory _url) public {
        restaurants[restaurantsCount] = Restaurant(restaurantsCount, _name, _location,_description,_url,0,true);
        restaurantsCount++;
        restaurantsCountExists++;
    }

    function addMenuItem (uint _restaurantId,string memory _name,string memory _description,uint _price, string memory _url) public {
        require(restaurants[_restaurantId].exists);
        menuItens[menuItensCount] = MenuItem(menuItensCount, _restaurantId, _name, _description, _price, _url,true);
        menuItensCount++;
        restaurants[_restaurantId].menuCount++;
    }

    function getRestaurants() public view returns (Restaurant[] memory){

        Restaurant[] memory itens = new Restaurant[](restaurantsCountExists);
        uint counter = 0;
        for(uint i=0;i<restaurantsCount;i++){
            if(restaurants[i].exists){
                itens[counter] = restaurants[i];
                counter++;
            }
        }
        return itens;

    }

    function getRestaurantMenu (uint _restaurantId) public view returns (MenuItem[] memory){
        require(restaurants[_restaurantId].exists);
        MenuItem[] memory itens = new MenuItem[](restaurants[_restaurantId].menuCount);
        uint counter = 0;
        for(uint i=0;i<menuItensCount;i++){
            if(menuItens[i].exists && menuItens[i].restaurantId == _restaurantId){
                itens[counter] = menuItens[i];
                counter++;
            }
        }
        return itens;
    

    }

    function editRestaurant(uint _restaurantId,string memory _name,string memory _location, string memory _description,string memory _url) public{
        require(restaurants[_restaurantId].exists);
        restaurants[_restaurantId].name = _name;
        restaurants[_restaurantId].location = _location;
        restaurants[_restaurantId].description = _description;
        restaurants[_restaurantId].imageURL = _url;
    }

    function editMenuItem(uint _menuItemId,string memory _name,uint _price, string memory _url) public {
        require( menuItens[_menuItemId].exists);
        menuItens[_menuItemId].name = _name;
        menuItens[_menuItemId].price = _price;
        menuItens[_menuItemId].imageURL = _url;
    }

    function deleteRestaurant(uint _restaurantId) public{
        require(restaurants[_restaurantId].exists);
        restaurantsCountExists--;      
        // Delete restaurant menu
        for(uint i=0;i<menuItensCount;i++){
            if(menuItens[i].exists && menuItens[i].restaurantId == _restaurantId){
                deleteMenuItem(i);
            }
        }

        restaurants[_restaurantId].exists = false;
    }

    function deleteMenuItem(uint _menuItemId) public {
        require(menuItens[_menuItemId].exists);
        require(restaurants[menuItens[_menuItemId].restaurantId].exists);
        restaurants[menuItens[_menuItemId].restaurantId].menuCount--;
        menuItens[_menuItemId].exists = false;
    }

} 