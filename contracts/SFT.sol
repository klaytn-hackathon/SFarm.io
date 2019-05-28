pragma solidity 0.4.24;

import "./SFarmToken.sol";

contract SFT is SFarmToken {

    function () {
        //if ether is sent to this address, send it back.
        throw;
    }

    string public name;
    uint8 public decimals;
    string public symbol;

    // should have the same name as the contract name
    function SFT() {
        balances[msg.sender] = 100000000;    // creator gets all initial tokens
        totalSupply = 100000000;             // total supply of token
        name = "SFarm";               // name of token
        decimals = 0;                  // amount of decimals
        symbol = "SFT";                // symbol of token
    }

    /* Approves and then calls the receiving contract */
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);

        if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { throw; }
        return true;
    }
}