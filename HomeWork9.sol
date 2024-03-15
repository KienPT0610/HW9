// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

interface IDigitalAsset{
    function getDetails() external view returns(string memory, string memory, address);
    function transferOwnership(address newOwner, string memory newName) external;
}

abstract contract AbstractAsset is IDigitalAsset {
    string internal name;
    address internal owner;
    string internal link;
    constructor(string memory _name) {
        name = _name;
        owner = msg.sender;
    }

    function getDetails() virtual override external view returns(string memory, string memory, address) {
        return (name, link, owner);
    }

    function transferOwnership(address newOwner, string memory newName) virtual override public {
        require(owner==msg.sender, "Only owner can use option!");
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
        name = newName;
    }
}

contract ArtAsset is AbstractAsset{
    string internal nameArtist;
    address internal artist;
    string internal uri;
    constructor(string memory _name, address addArtist,string memory _uri) AbstractAsset(_name) {
        nameArtist = _name;
        uri = _uri;
        artist = addArtist;
    }

    function transferOwnership(address newOwner, string memory newName) public override {
        super.transferOwnership(newOwner, newName);
        // owner = newOwner;
    }

    function getDetails() override external view returns(string memory, string memory, address) {
        return (name, uri, owner);
    }

}



