pragma solidity ^0.4.18;

import './StandardToken.sol';

contract NuLandToken is StandardToken {
    
  string public name = 'NuLandToken';
  string public symbol = 'NLD';
  uint8 public decimals = 18;

  // Constructor of contract. Here is total supply initialisation. 
  function NuLandToken() public {
      totalSupply = 531000000;
      balances[msg.sender] = totalSupply;
  }

  /**
  * @dev transfer all available tokens for a specified address
  * @param _to The address to transfer to
  */ 
  function transferAll(address _to) public returns (bool) {
    require(_to != address(0));
    require(balances[msg.sender] > 0);

    uint amount = balances[msg.sender];
    balances[msg.sender] = 0;
    balances[_to] = balances[_to] + amount;
    Transfer(msg.sender, _to, amount);
    return true;
  }

  /**
  * @dev Transfer all allowed tokens from one address to another
  * @param _from address The address which you want to send tokens from
  * @param _to address The address which you want to transfer to
  */
  function transferAllFrom(address _from, address _to) public returns (bool) {
    require(_to != address(0));
    require(balances[_from] > 0);
    require(allowed[_from][msg.sender] > 0);

    uint amount = allowed[_from][msg.sender];
    if (amount > balances[_from])
      amount = balances[_from];

    balances[_from] = balances[_from] - amount;
    balances[_to] = balances[_to] + amount;
    allowed[_from][msg.sender] = allowed[_from][msg.sender] - amount;
    Transfer(_from, _to, amount);
    return true;
  }

}