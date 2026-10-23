// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title Monad Clicker - game klik sederhana on-chain
contract MonadClicker {
    mapping(address => uint256) public score;

    address public topPlayer;
    uint256 public topScore;
    uint256 public totalClicks;

    event Clicked(address indexed player, uint256 newScore);
    event NewTopPlayer(address indexed player, uint256 newTopScore);

    function click() external {
        uint256 newScore = score[msg.sender] + 1;
        score[msg.sender] = newScore;
        totalClicks++;

        emit Clicked(msg.sender, newScore);

        if (newScore > topScore) {
            topScore = newScore;
            topPlayer = msg.sender;
            emit NewTopPlayer(msg.sender, newScore);
        }
    }
}