#!/bin/bash

# Deployed contract addresses
CONTRACT_A="0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9"
CONTRACT_B="0x5FbDB2315678afecb367f032d93F642f64180aa3"
PRIVATE_KEY="0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"

# Hit ball from Chain A (901) to Chain B (902)
echo "Hitting ball from Chain A to Chain B:"
cast send $CONTRACT_A "hitBallTo(uint256)" 902 \
  --rpc-url http://127.0.0.1:9545 \
  --private-key $PRIVATE_KEY