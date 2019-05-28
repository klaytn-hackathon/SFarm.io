pragma solidity 0.4.24;

import "./AccessControl.sol";

contract FarmerPool is AccessControl {
    struct Farmer{
        uint id;
        string name;
        uint dateOfBirth;
        uint social;
        uint status;
    }

    uint constant active = 1;
    uint constant pending = 2;
    uint constant deleted = 3;

    mapping (uint => Farmer) farmers;
    uint public count = 0;
 
    function createFarmer(uint id, string name, uint dateOfBirth, uint social) public {
        require (isUser(msg.sender, "createFarmer"), "access prohibited");
        
        farmers[count] = Farmer(id, name, dateOfBirth, social, pending);
        count++;
    }

    function getFarmer(uint index)
        constant public returns (uint id, string name, uint dateOfBirth, uint social, uint status) {
            id = farmers[index].id;
            name = farmers[index].name;
            dateOfBirth = farmers[index].dateOfBirth;
            social = farmers[index].social;
            status = farmers[index].status;
    }

    function getFarmerById(uint id)
        constant public returns (uint idRet, string name, uint dateOfBirth, uint social, uint status) {

        for (uint8 i=0; i < count; i++) {
            if (farmers[i].id == id) {
                idRet = farmers[i].id;
                name = farmers[i].name;
                dateOfBirth = farmers[i].dateOfBirth;
                social = farmers[i].social;
                status = farmers[i].status;
                return;
            }
        }
    }

    function updateFarmer(uint index, string name) public {
        require (isUser(msg.sender, "updateFarmer"), "access prohibited");
        require (index < count, "out of index");

        farmers[index].name = name;
    }

    function updateFarmerStatus(uint index, uint status) public {
        require (isUser(msg.sender, "updateCustomer"), "access prohibited");
        require (index < count, "out of index");

        farmers[index].status = status;
    }
   
}
