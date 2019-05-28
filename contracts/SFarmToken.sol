pragma solidity 0.4.24;

import "./ERC20Token.sol";

contract SFarmToken is ERC20Token {

    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
    uint256 public totalSupply;

}