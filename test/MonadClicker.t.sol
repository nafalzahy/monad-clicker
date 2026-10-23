// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {MonadClicker} from "../src/MonadClicker.sol";

contract MonadClickerTest is Test {
    MonadClicker game;
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");

    function setUp() public {
        game = new MonadClicker();
    }

    function test_ClickAddsScore() public {
        vm.prank(alice);
        game.click();
        assertEq(game.score(alice), 1);
        assertEq(game.totalClicks(), 1);
    }

    function test_TopPlayerChanges() public {
        vm.prank(alice);
        game.click();
        assertEq(game.topPlayer(), alice);

        vm.startPrank(bob);
        game.click();
        game.click();
        vm.stopPrank();

        assertEq(game.topPlayer(), bob);
        assertEq(game.topScore(), 2);
    }
}