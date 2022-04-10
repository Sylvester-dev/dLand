// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract dLand is ERC721, Ownable {
    uint256 public cost = 0.001 ether;
    uint256 public maxSupply = 20;
    uint256 public totalSupply = 0;

    struct Land {
        string name;
        address owner;
        int256 posX;
        int256 posY;
        int256 posZ;
        uint256 sizeX;
        uint256 sizeY;
        uint256 sizeZ;
    }

    Land[] public allLands;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _cost
    ) ERC721(_name, _symbol) {
        cost = _cost;

        allLands.push(Land("Factory1", address(0x0), 0, 0, 0, 9, 9, 9));
        allLands.push(Land("Stadium", address(0x0), 0, 10, 0, 9, 9, 9));
        allLands.push(Land("University", address(0x0), 0, -10, 0, 9, 9, 9));
        allLands.push(Land("House1", address(0x0), -10, 0, 0, 9, 9, 9));
        allLands.push(Land("Super Market", address(0x0), 10, 0, 0, 9, 9, 9));
        allLands.push(Land("Shopping Plaza", address(0x0), 0, 20, 0, 9, 9, 9));
        allLands.push(Land("House2", address(0x0), -20, 0, 0, 9, 9, 9));
        allLands.push(Land("Apartments1", address(0x0), 0, -20, 0, 9, 9, 9));
        allLands.push(Land("Fast Food Center", address(0x0), 20, 0, 0, 9, 9, 9));
        allLands.push(Land("Gas Station", address(0x0), 0, 30, 0, 9, 9, 9));
        allLands.push(Land("Park", address(0x0), -30, 0, 0, 9, 9, 9));
        allLands.push(Land("House3", address(0x0), 0, -30, 0, 9, 9, 9));
        allLands.push(Land("Coffee Shop", address(0x0), 30, 0, 0, 9, 9, 9));
        allLands.push(Land("Residence", address(0x0), 0, 40, 0, 9, 9, 9));
        allLands.push(Land("Factory2", address(0x0), -40, 0, 0, 9, 9, 9));
        allLands.push(Land("Museum", address(0x0), 0, -40, 0, 9, 9, 9));
        allLands.push(Land("Gaming Zone", address(0x0), 40, 0, 0, 9, 9, 9));
        allLands.push(Land("Hospital", address(0x0), 0, 50, 0, 9, 9, 9));
        allLands.push(Land("Club", address(0x0), -50, 0, 0, 9, 9, 9));
        allLands.push(Land("Apartments2", address(0x0), 0, -50, 0, 9, 9, 9));
    
    }

    function mint(uint256 _id) public payable {
        uint256 supply = totalSupply;
        require(supply <= maxSupply);
        require(allLands[_id - 1].owner == address(0x0));
        require(msg.value >= cost);

        // NOTE: tokenID always starts from 1, but our array starts from 0
        allLands[_id - 1].owner = msg.sender;
        totalSupply = totalSupply + 1;

        _safeMint(msg.sender, _id);
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );

        // Update Land ownership
        allLands[tokenId - 1].owner = to;

        _transfer(from, to, tokenId);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public override {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );

        // Update Land ownership
        allLands[tokenId - 1].owner = to;

        _safeTransfer(from, to, tokenId, _data);
    }

    /**
    * withdraw sends all the ether in the contract 
    * to the owner of the contract
     */
    function withdraw() public onlyOwner  {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) =  _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    // Public View Functions
    function getallLands() public view returns (Land[] memory) {
        return allLands;
    }

    function getland(uint256 _id) public view returns (Land memory) {
        return allLands[_id - 1];
    }

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}
}

//0x5FbDB2315678afecb367f032d93F642f64180aa3