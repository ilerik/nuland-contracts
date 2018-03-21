pragma solidity 0.4.20;

contract NuLandRegistry{
  // Structure to store data managed by a user
  struct User {
    // Ethereum address of name owner
    address addr;
    // Double-Ethereum-SHA-3 hash of user password and one Ethereum-SHA-3 for user name
    bytes32 pswdHash;
  }    
    
  // Registry storage
  mapping(bytes32 => User) public registry;
  
  // Events
  event SignIn(bytes32 indexed nameHash, address indexed nameOwner);
  event ChangeAddressOfOwner(bytes32 indexed nameHash, address indexed nameOwner, address newOwner);
  event ChangeUserName(bytes32 indexed oldNameHash, bytes32 indexed newNameHash, address nameOwner);

  // Constructor
  function NuLandRegistry() public {}

  // Check if the user has been registered
  function signIn(bytes32 nameHash, bytes32 pswdHash) public constant returns (bool) {
      return (registry[nameHash].pswdHash == pswdHash);
  }

  // Register new user
  function signUp(bytes32 nameHash, bytes32 pswdHash) public returns (bool) {
      if (registry[nameHash].addr != 0x0) {
        return false;           
      }
      registry[nameHash].addr = msg.sender;
      registry[nameHash].pswdHash = pswdHash;
      SignIn(nameHash, msg.sender);
      return true;
  }
    
  // Change the owner address
  function changeNameOwner(bytes32 nameHash, address newOwner) public returns (bool) {
      if (registry[nameHash].addr != msg.sender) {
          return false;
      }
      registry[nameHash].addr = newOwner;
      ChangeAddressOfOwner(nameHash, msg.sender, newOwner);
      return true;
  }

  // Change the owner password
  function changePassword(bytes32 nameHash, bytes32 newPswdHash) public returns (bool) {
      if (registry[nameHash].addr != msg.sender) {
          return false;
      }
      registry[nameHash].pswdHash = newPswdHash;
      return true;
  }
  
  // Create new account and free the old one
  function changeUserName(bytes32 nameHash, bytes32 newNameHash) public returns (bool) {
    if (registry[nameHash].addr != msg.sender || registry[newNameHash].addr != 0x0) {
      return false;
    }
    registry[newNameHash].addr = msg.sender;
    registry[newNameHash].pswdHash = registry[nameHash].pswdHash;
    delete registry[nameHash];
    ChangeUserName(nameHash, newNameHash, msg.sender);
    return true;
  }
}