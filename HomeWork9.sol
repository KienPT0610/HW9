// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

interface IDigitalAsset {
    function getDetails() external view returns (string memory, string memory, address);
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

    function getDetails() virtual override external view returns (string memory, string memory, address) {
        return (name, link, owner);
    }

    function transferOwnership(address newOwner, string memory newName) virtual override public {
        require(owner == msg.sender, "Only owner can use option!");
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
        name = newName;
    }
}

contract ArtAsset is AbstractAsset {
    string internal nameArtist;
    address internal artist;
    string internal uri;

    constructor(string memory _name, address addArtist, string memory _uri) AbstractAsset(_name) {
        nameArtist = _name;
        uri = _uri;
        artist = addArtist;
    }

    function transferOwnership(address newOwner, string memory newName) public override {
        super.transferOwnership(newOwner, newName);
    }

    function getDetails() override external view returns (string memory, string memory, address) {
        return (name, uri, owner);
    }
}


contract MusicAsset is AbstractAsset {
    string internal nameSong;
    
    constructor(string memory nameSingle, string memory _nameSong) AbstractAsset(nameSingle) {
        nameSong = _nameSong;
    }

    function getDetails() virtual override external view returns (string memory, string memory, address) {
        return (name, nameSong, owner);
    }

    function transferOwnership(address newOwner, string memory newNameSingle) public override {
        super.transferOwnership(newOwner, newNameSingle);
    }
}

contract AssetFactory {
    enum AssetType { Art, Music } 

    mapping(uint256 => address) public assetContracts; 
    uint256 public assetCount; 

    event AssetCreated(uint256 indexed assetId, address indexed assetAddress);

    function createAssetArt(AssetType _assetType, string memory _name, address _artist, string memory _uri) external {
        if (_assetType == AssetType.Art) {
            ArtAsset newAsset = new ArtAsset(_name, _artist, _uri);
            assetContracts[assetCount] = address(newAsset);
            assetCount++;
            emit AssetCreated(assetCount - 1, address(newAsset));
        }
    }

    function createAssetMusic(AssetType _assetType, string memory _nameSingle, address newAuthor, string memory _nameSong) external {
        if (_assetType == AssetType.Music) {
            ArtAsset newAsset = new ArtAsset(_nameSingle, newAuthor, _nameSong);
            assetContracts[assetCount] = address(newAsset);
            assetCount++;
            emit AssetCreated(assetCount - 1, address(newAsset));
        }
    }
}
