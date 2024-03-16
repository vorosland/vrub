// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract VoroslandRuble is ERC20 {
    address payable public owner;

    // EVENTS
    event TokensBought(address indexed to, uint256 amount);
    event TokensSold(address indexed from, uint256 amount);
    event TokenExchange(address indexed from, uint256 amount);
    constructor() ERC20("Vorosland Ruble", "VRUB") {
        owner = payable(msg.sender);
        _mint(owner, 900000000 * (10 ** decimals()));
    }

    function exchange(uint256 amount) public payable {
        require(msg.value == amount, "You must send the exact amount of Ether");
        // transfer tokens to the sender
        _transfer(owner, msg.sender, amount * (10 ** decimals()));
        // transfer ether to contract itself
        owner.transfer(msg.value);
    }

    function withdraw() public onlyOwner {
        owner.transfer(address(this).balance);
    }

    /* function to buy tokens with python points */
    function buy(uint256 amount) public {
        _mint(msg.sender, amount * (10 ** decimals()));
        emit TokensBought(msg.sender, amount);
    }

    function sell(uint256 amount) public {
        _burn(msg.sender, amount * (10 ** decimals()));
        emit TokensSold(msg.sender, amount);
    }

    //reusable modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
}