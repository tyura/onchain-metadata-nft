// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract OnchainMetadataNFT is ERC721URIStorage {
    struct Attributes {
        string packId;
        string cardBaseId;
        uint indivisualId;
        string frameId;
        bool isVoiceOpened;
        bool isUsed;
        string firstUser;
        uint usedCount;
        uint altIllustId;
        uint cost;
        uint offensivePower;
        uint hp;
        string skill1;
        string skill2;
        string skill3;
        string skill4;
        string lines;
        string illustrator;
        string cv;
    }
    struct Metadata {
        string name;
        string description;
        string image;
        Attributes attributes;
    }

    Metadata[] private _metadata;

    constructor() ERC721("Meta Data Create Token 1", "MDCT1") {}

    function mintToken(address to, Metadata memory metadata) external {
        uint256 tokenId = _metadata.length;
        _safeMint(to, tokenId);
        _metadata.push(metadata);
        string memory metadataString = tokenURI(tokenId);
        _setTokenURI(tokenId, metadataString);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        bytes memory bytesName = abi.encodePacked(
            '"name":"',
            _metadata[tokenId].name,
            '"'
        );

        bytes memory bytesDescription = abi.encodePacked(
            '"description":"',
            _metadata[tokenId].description,
            '"'
        );

        bytes memory bytesImage = abi.encodePacked(
            '"image":"',
            _metadata[tokenId].image,
            '"'
        );

        bytes memory bytesObject = abi.encodePacked(
            "{",
            bytesName,
            ",",
            bytesDescription,
            ",",
            bytesImage,
            ",",
            _formatAttributes(tokenId),
            "}"
        );

        return (string(bytesObject));
    }

    function updateImage(uint256 tokenId, string calldata image) external {
        _metadata[tokenId].image = image;
        string memory metadata = tokenURI(tokenId);
        _setTokenURI(tokenId, metadata);
    }

    function _formatAttribute(
        string memory traitType,
        string memory value
    ) private pure returns (bytes memory) {
        return
            abi.encodePacked(
                "{",
                '"trait_type":"',
                traitType,
                '",',
                '"value":"',
                value,
                '"',
                "}"
            );
    }

    function _formatAttributeUint(
        string memory traitType,
        uint value
    ) private pure returns (bytes memory) {
        return _formatAttribute(traitType, Strings.toString(value));
    }

    function _formatAttributeBool(
        string memory traitType,
        bool value
    ) private pure returns (bytes memory) {
        return _formatAttribute(traitType, value ? "true" : "false");
    }

    function _formatAttributes(
        uint256 tokenId
    ) private view returns (bytes memory) {
        bytes memory attributes = abi.encodePacked('"attributes":[');
        attributes = abi.encodePacked(
            attributes,
            _formatAttribute("PackId", _metadata[tokenId].attributes.packId),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttribute(
                "CardBaseId",
                _metadata[tokenId].attributes.cardBaseId
            ),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttributeUint(
                "IndivisualId",
                _metadata[tokenId].attributes.indivisualId
            ),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttribute("FrameId", _metadata[tokenId].attributes.frameId),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttributeBool(
                "IsVoiceOpened",
                _metadata[tokenId].attributes.isVoiceOpened
            ),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttributeBool(
                "IsUsed",
                _metadata[tokenId].attributes.isUsed
            ),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttribute(
                "FirstUser",
                _metadata[tokenId].attributes.firstUser
            ),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttributeUint(
                "UsedCount",
                _metadata[tokenId].attributes.usedCount
            ),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttributeUint("Cost", _metadata[tokenId].attributes.cost),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttributeUint(
                "OffensivePower",
                _metadata[tokenId].attributes.offensivePower
            ),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttributeUint("Hp", _metadata[tokenId].attributes.hp),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttribute("Skill1", _metadata[tokenId].attributes.skill1),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttribute("Skill2", _metadata[tokenId].attributes.skill2),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttribute("Skill3", _metadata[tokenId].attributes.skill3),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttribute("Skill4", _metadata[tokenId].attributes.skill4),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttribute("Lines", _metadata[tokenId].attributes.lines),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttribute(
                "Illustrator",
                _metadata[tokenId].attributes.illustrator
            ),
            ","
        );
        attributes = abi.encodePacked(
            attributes,
            _formatAttribute("Cv", _metadata[tokenId].attributes.cv),
            "]"
        );
        return attributes;
    }
}
