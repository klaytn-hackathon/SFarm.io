pragma solidity 0.4.24;

contract AccessControl {
    address public owner;     
    address [] public users;

    event LogAccess(address indexed by, uint indexed accessTime, string method, string desc);

    constructor() {
        owner = msg.sender;
        users.push(owner);
    }

    function isUser(address candidate, string method) returns (bool){
        for(uint8 i = 0; i < users.length; i++){
            if (users[i] == candidate){
                LogAccess(candidate, now, method, "successful access");

                return true;
            }
        }

        LogAccess(candidate, now,method,  "failed access");

        return false;
    }

    function addUser(address user){
        if (msg.sender != owner) throw;

        users.push(user);
    }

    function getUser(uint i) constant returns (address){
        return users[i];
    }

    function getUserCount() constant returns (uint){
        return users.length;
    }

    function deleteIthUser(uint i){
        if (msg.sender != owner) throw;

        delete users[i];
    }   
}