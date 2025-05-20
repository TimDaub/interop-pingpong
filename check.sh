#!/bin/bash

# Deployed contract addresses
CONTRACT_A="0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9"
CONTRACT_B="0x5FbDB2315678afecb367f032d93F642f64180aa3"

# Check ball on chain A (901)
echo "Checking ball on OPChainA (901):"
cast call $CONTRACT_A "ball()(uint256,uint256,address)" --rpc-url http://127.0.0.1:9545

# Check ball on chain B (902)
echo -e "\nChecking ball on OPChainB (902):"
cast call $CONTRACT_B "ball()(uint256,uint256,address)" --rpc-url http://127.0.0.1:9546