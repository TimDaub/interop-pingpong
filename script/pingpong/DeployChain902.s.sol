// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {CrossChainPingPong} from "../../src/CrossChainPingPong.sol";

contract DeployChain902Script is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();

        CrossChainPingPong game = new CrossChainPingPong{salt: "pingpong"}();
        console.log("Deployed at: ", address(game));
    }
}
