// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDigitalAsset {
  function getDetails() external view returns (string memory name, address owner);
  function transferOwnership(address newOwner) external;
}

abstract contract AbstractAsset is IDigitalAsset {
  string internal name;
  address internal owner;
  constructor(string memory _name){
  name = _name;
  owner = msg.sender;

}
  function getDetails() external view override returns (string memory name, address owner) {
    name = _name;
    owner = _owner;
  }

  function transferOwnership(address newOwner) external override virtual;
}
