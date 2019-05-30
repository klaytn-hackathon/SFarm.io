pragma solidity 0.4.24;

import "./AccessControl.sol";

contract FarmerPool is AccessControl {
    struct Prediction {
        uint year;
        uint supply;
        uint demand;
        uint reward;
    }

    struct Crop {
        uint id;
        string name;
        string place;
        uint area;
        uint[] predictionList;
        mapping (uint => Prediction) predictionStructs;
    }

    struct Farmer {
        uint id;
        string name;
        uint dateOfBirth;
        uint social;
        uint status;
        uint[] cropList;
        mapping (uint => Crop) cropStructs;
    }

    uint[] farmerList;
    mapping (uint => Farmer) farmerStructs;

    uint constant active = 1;
    uint constant pending = 2;
    uint constant deleted = 3;

    function sqrt(uint x) internal pure returns (uint y) {
        if (x == 0) return 0;
        else if (x <= 3) return 1;
        uint z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }

    function createFarmer(uint farmerId, string name, uint dateOfBirth, uint social) public {
        require (isUser(msg.sender, "createFarmer"), "access prohibited");

        farmerStructs[farmerId].id = farmerId;
        farmerStructs[farmerId].name = name;
        farmerStructs[farmerId].dateOfBirth = dateOfBirth;
        farmerStructs[farmerId].social = social;
        farmerStructs[farmerId].status = pending;
        farmerList.push(farmerId);
    }

    function getFarmer(uint farmerId)
        constant public returns (uint id, string name, uint dateOfBirth, uint social, uint status) {
        
        return(
            farmerStructs[farmerId].id,
            farmerStructs[farmerId].name,
            farmerStructs[farmerId].dateOfBirth,
            farmerStructs[farmerId].social,
            farmerStructs[farmerId].status
        );
    }

    function getFarmerCount() public constant returns(uint farmerCount) {
        return farmerList.length;
    }

    function getFarmerIdAtIndex(uint row) public constant returns(uint farmerId) {
        return farmerList[row];
    }

    function updateFarmerName(uint index, string name) public {
        require (isUser(msg.sender, "updateFarmer"), "access prohibited");
        require (index < farmerList.length, "out of index");

        farmerStructs[farmerList[index]].name = name;
    }

    function updateFarmerStatus(uint index, uint status) public {
        require (isUser(msg.sender, "updateCustomer"), "access prohibited");
        require (index < farmerList.length, "out of index");

        farmerStructs[farmerList[index]].status = status;
    }
    
    function addCrop(uint farmerId, uint cropId, string name, string place, uint area) public {
        farmerStructs[farmerId].cropStructs[cropId].id = cropId; 
        farmerStructs[farmerId].cropStructs[cropId].name = name; 
        farmerStructs[farmerId].cropStructs[cropId].place = place; 
        farmerStructs[farmerId].cropStructs[cropId].area = area;   
        farmerStructs[farmerId].cropList.push(cropId);   
    }

    function getCrop(uint farmerId, uint cropId) 
        constant public returns (string name, string place, uint area) {

        return (
            farmerStructs[farmerId].cropStructs[cropId].name,
            farmerStructs[farmerId].cropStructs[cropId].place,
            farmerStructs[farmerId].cropStructs[cropId].area   
        );
    }

    function getCropCount(uint farmerId) public constant returns(uint cropCount) {
        return farmerStructs[farmerId].cropList.length;
    }

    function getCropIdAtIndex(uint farmerId, uint row) public constant returns(uint cropId) {
        return farmerStructs[farmerId].cropList[row];
    }

    function setPrediction(uint farmerId, uint cropId, uint year, uint supply, uint demand) public {
        uint reward = sqrt((supply - demand) * (supply - demand));

        farmerStructs[farmerId].cropStructs[cropId].predictionStructs[year].year = year; 
        farmerStructs[farmerId].cropStructs[cropId].predictionStructs[year].supply = supply;
        farmerStructs[farmerId].cropStructs[cropId].predictionStructs[year].demand = demand;
        farmerStructs[farmerId].cropStructs[cropId].predictionStructs[year].reward = reward;
        farmerStructs[farmerId].cropStructs[cropId].predictionList.push(year); 
    }

    function getPrediction(uint farmerId, uint cropId, uint year) 
        constant public returns (uint supply, uint demand, uint reward) {
        
        return (
            farmerStructs[farmerId].cropStructs[cropId].predictionStructs[year].supply,
            farmerStructs[farmerId].cropStructs[cropId].predictionStructs[year].demand,
            farmerStructs[farmerId].cropStructs[cropId].predictionStructs[year].reward
        );
    }

    function getPredictionCount(uint farmerId, uint cropId) public constant returns(uint predictionCount) {
        return farmerStructs[farmerId].cropStructs[cropId].predictionList.length;
    }

    function getPredictionIdAtIndex(uint farmerId, uint cropId, uint row) public constant returns(uint predictionId) {
        return farmerStructs[farmerId].cropStructs[cropId].predictionList[row];
    }
   
}
