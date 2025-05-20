#!/bin/bash

# Deployed contract addresses
CONTRACT_A="0xEFd7B7eCD385EdB10311Deeb760b433E215d101A"
CONTRACT_B="0xEFd7B7eCD385EdB10311Deeb760b433E215d101A"
PRIVATE_KEY="0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"

# Hit ball from Chain B (902) to Chain A (901)
echo "Hitting ball from Chain B to Chain A:"
cast send $CONTRACT_B "hitBallTo(uint256)" 901 \
  --rpc-url http://127.0.0.1:9546 \
  --private-key $PRIVATE_KEY
