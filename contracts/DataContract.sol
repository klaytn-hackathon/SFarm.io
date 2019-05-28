pragma solidity 0.4.24;

import "./ACLContract.sol";

contract DataContract is ACLContract {
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
 
    function createFarmer(uint id, string name, uint dateOfBirth, uint social){
        if (isUser(msg.sender, "createFarmer")) {
            farmers[count] = Farmer(id, name, dateOfBirth, social, pending);
            count++;
        } else {
            throw;
        }
    }

    function getFarmer(uint index)
        constant returns (uint id, string name, uint dateOfBirth, uint social, uint status) {
            id = farmers[index].id;
            name = farmers[index].name;
            dateOfBirth = farmers[index].dateOfBirth;
            social = farmers[index].social;
            status = farmers[index].status;
    }

    function getFarmerById(uint id)
        constant returns (uint idRet, string name, uint dateOfBirth, uint social, uint status) {

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

    function updateFarmer(uint index, string name) {
        if (isUser(msg.sender, "updateFarmer")) {
            if (index > count) {
                throw;
            }
            farmers[index].name = name;
        } else {
            throw;
        }
    }

    function updateFarmerStatus(uint index, uint status) {
        if (isUser(msg.sender, "updateCustomer")) {
            if (index > count) {
                throw;
            }
            farmers[index].status = status;
        } else {
            throw;
        }
    }
   
}
