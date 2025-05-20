#!/bin/bash

# Deployed contract addresses
CONTRACT_A="0x0165878A594ca255338adfa4d48449f69242Eb8F"
CONTRACT_B="0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512"

# Check ball on chain A (901)
echo "Checking ball on OPChainA (901):"
cast call $CONTRACT_A "ball()(uint256,uint256,address)" --rpc-url http://127.0.0.1:9545

# Check ball on chain B (902)
echo -e "\nChecking ball on OPChainB (902):"
cast call $CONTRACT_B "ball()(uint256,uint256,address)" --rpc-url http://127.0.0.1:9546
