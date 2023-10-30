//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    string[] private _packIds; // KMY_001
    bool[] private _isUseds;  
    string[] private _firstUsedUsers; 
    int[] private _useCounts;
    string[] private _images;

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721( "Meta Data Create Token 1", "MDCT1" ) {}

    function mintToken( string calldata packId, string calldata isUsed, string calldata firstUsedUser, string calldata useCount, string calldata image ) external {
        uint256 tokenId = _packIds.length;
        _safeMint( msg.sender, tokenId );

        _packIds.push( packId );
        _isUseds.push( isUsed );
        _firstUsedUsers.push( firstUsedUser );
        _useCounts.push( useCount );
        _images.push( image );
    }

       function tokenURI( uint256 tokenId ) public view override returns (string memory) {
        require( _exists( tokenId ), "nonexsitent token" );

        bytes memory bytesPackId = abi.encodePacked(
            '"packId":"', _packIds[tokenId], '"'
        );

        bytes memory bytesIsUsed = abi.encodePacked(
            '"isUsed":"', _isUseds[tokenId], '"'
        );

        bytes memory bytesFirstUsedUser = abi.encodePacked(
            '"firstUsedUser":"', _firstUsedUsers[tokenId], '"'
        );

        bytes memory bytesUseCount = abi.encodePacked(
            '"useCount":"', _useCounts[tokenId], '"'
        );

        bytes memory bytesImage = abi.encodePacked(
            '"image":"', _images[tokenId], '"'
        );

        bytes memory bytesObject = abi.encodePacked(
            '{',
                bytesPackId, ',',
                bytesIsUsed, ',',
                bytesFirstUsedUser, ',',
                bytesUseCount, ',',
                bytesImage,
            '}'
        );

        bytes memory bytesMetadata = abi.encodePacked(
            'data:application/json;base64,',
            Base64.encode( bytesObject )
        );

        return( string( bytesMetadata ) );
    }
}
