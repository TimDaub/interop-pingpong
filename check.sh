#!/bin/bash

# Deployed contract addresses
CONTRACT_A="0xEFd7B7eCD385EdB10311Deeb760b433E215d101A"
CONTRACT_B="0xEFd7B7eCD385EdB10311Deeb760b433E215d101A"

# Check ball on chain A (901)
echo "Checking ball on OPChainA (901):"
cast call $CONTRACT_A "ball()(uint256,uint256,address)" --rpc-url http://127.0.0.1:9545

# Check ball on chain B (902)
echo -e "\nChecking ball on OPChainB (902):"
cast call $CONTRACT_B "ball()(uint256,uint256,address)" --rpc-url http://127.0.0.1:9546
