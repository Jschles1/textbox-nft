// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// We first import some OpenZeppelin contracts
// We need some util functions for strings.
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "hardhat/console.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract TextBox is ERC721URIStorage {
  // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  uint maxMints = 250;
  uint totalNFTsMinted = 0;

  event NewEpicNFTMinted(address sender, uint256 tokenId);

  // We need to pass the name of our NFTs token and it's symbol.
  constructor() ERC721("TextBox NFT Collection", "TEXTBOX")  {
    console.log('Textbox Contract deployed.');
  }

  // A function our user will hit to get their NFT.
  function makeAnEpicNFT(string memory metadataURI) public {
    console.log('About to make an epic NFT!');
    uint256 newItemId = _tokenIds.current();
    require(totalNFTsMinted != maxMints, "Sorry, max NFT's have been minted.");

    // Mint NFT to the sender
    _safeMint(msg.sender, newItemId);
  
    // We'll be setting the tokenURI later!
    _setTokenURI(newItemId, metadataURI);
  
    // Change NFT ID for next person
    _tokenIds.increment();
    totalNFTsMinted++;
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    emit NewEpicNFTMinted(msg.sender, newItemId);
  }

  function _baseURI() internal pure override returns (string memory) {
    return "ipfs://";
  }

  function getTotalNFTsMinted() public view returns (uint) {
    return totalNFTsMinted;
  }
}