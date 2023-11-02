// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract OnchainMetadataNFT is ERC721URIStorage {
    string[] private _packIds;
    bool[] private _isUseds;
    string[] private _firstUsedUsers;
    int[] private _useCounts;
    string[] private _images;

    constructor() ERC721("Meta Data Create Token 1", "MDCT1") {}

    function mintToken(
        string calldata packId,
        bool isUsed,
        string calldata firstUsedUser,
        int useCount,
        string calldata image
    ) external {
        uint256 tokenId = _packIds.length;
        _safeMint(msg.sender, tokenId);

        _packIds.push(packId);
        _isUseds.push(isUsed);
        _firstUsedUsers.push(firstUsedUser);
        _useCounts.push(useCount);
        _images.push(image);
        string memory metadata = tokenURI(tokenId);
        _setTokenURI(tokenId, metadata);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        bytes memory bytesPackId = abi.encodePacked(
            '"packId":"',
            _packIds[tokenId],
            '"'
        );

        bytes memory bytesIsUsed = abi.encodePacked(
            '"isUsed":"',
            _boolToString(_isUseds[tokenId]),
            '"'
        );

        bytes memory bytesFirstUsedUser = abi.encodePacked(
            '"firstUsedUser":"',
            _firstUsedUsers[tokenId],
            '"'
        );

        bytes memory bytesUseCount = abi.encodePacked(
            '"useCount":"',
            Strings.toString(uint256(_useCounts[tokenId])),
            '"'
        );

        bytes memory bytesImage = abi.encodePacked(
            '"image":"',
            _images[tokenId],
            '"'
        );

        bytes memory bytesObject = abi.encodePacked(
            "{",
            bytesPackId,
            ",",
            bytesIsUsed,
            ",",
            bytesFirstUsedUser,
            ",",
            bytesUseCount,
            ",",
            bytesImage,
            "}"
        );

        return (string(bytesObject));
    }

    function updateImage(uint256 tokenId, string calldata image) external {
        _images[tokenId] = image;
        string memory metadata = tokenURI(tokenId);
        _setTokenURI(tokenId, metadata);
    }

    function _boolToString(bool value) private pure returns (string memory) {
        return value ? "true" : "false";
    }
}
