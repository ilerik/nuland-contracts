pragma solidity ^0.4.18;


import './contracts-zeppelin/ERC20Basic.sol';


/**
 * @title Basic token
 *
 * @dev Basic version of StandardToken, with no allowances.
 * @dev This code is based on the zeppelin-solidity BasicToken contract,
 * @dev but without using SafeMath library
 * @dev https://github.com/OpenZeppelin/zeppelin-solidity/blob/master/contracts/token/BasicToken.sol
 */
contract BasicToken is ERC20Basic {
  
  mapping(address => uint256) balances;

  /**
  * @dev transfer token for a specified address
  * @param _to The address to transfer to
  * @param _value The amount to be transferred
  */
  function transfer(address _to, uint256 _value) public returns (bool) {
    require(_to != address(0));
    require(_value <= balances[msg.sender]);

    balances[msg.sender] = balances[msg.sender] - _value;
    balances[_to] = balances[_to] + _value;
    Transfer(msg.sender, _to, _value);
    return true;
  }

  /**
  * @dev Gets the balance of the specified address.
  * @param _owner The address to query the the balance of.
  * @return An uint256 representing the amount owned by the passed address.
  */
  function balanceOf(address _owner) public view returns (uint256 balance) {
    return balances[_owner];
  }

}
