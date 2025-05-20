#!/bin/bash

# Deployed contract addresses
CONTRACT_A="0x8d393f51F715A8A55EB3D4F14b13c4E2AEbca1c6"
CONTRACT_B="0x8d393f51F715A8A55EB3D4F14b13c4E2AEbca1c6"

# Check ball on chain A (901)
echo "Checking ball on OPChainA (901):"
cast call $CONTRACT_A "ball()(uint256,uint256,address)" --rpc-url http://127.0.0.1:9545

# Check ball on chain B (902)
echo -e "\nChecking ball on OPChainB (902):"
cast call $CONTRACT_B "ball()(uint256,uint256,address)" --rpc-url http://127.0.0.1:9546
