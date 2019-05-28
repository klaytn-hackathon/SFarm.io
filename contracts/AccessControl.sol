pragma solidity 0.4.24;

contract AccessControl {
    address public owner;     
    address [] public users;

    event LogAccess(address indexed by, uint indexed accessTime, string method, string desc);

    constructor() public {
        owner = msg.sender;
        users.push(owner);
    }

    function isUser(address candidate, string method) public returns (bool){
        for(uint8 i = 0; i < users.length; i++){
            if (users[i] == candidate){
                emit LogAccess(candidate, now, method, "successful access");

                return true;
            }
        }

        emit LogAccess(candidate, now, method,  "failed access");

        return false;
    }

    function getUser(uint i) constant public returns (address){
        return users[i];
    }

    function getUserCount() constant public returns (uint){
        return users.length;
    }

    function addUser(address user) public {
        require(msg.sender == owner);
        users.push(user);
    }

    function deleteUser(uint i) public {
        require(msg.sender == owner);
        delete users[i];
    }   
}