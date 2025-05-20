#!/bin/bash

# Deployed contract addresses
CONTRACT_A="0xEFd7B7eCD385EdB10311Deeb760b433E215d101A"
CONTRACT_B="0xEFd7B7eCD385EdB10311Deeb760b433E215d101A"
PRIVATE_KEY="0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"

# Hit ball from Chain A (901) to Chain B (902)
echo "Hitting ball from Chain A to Chain B:"
cast send $CONTRACT_A "hitBallTo(uint256)" 902 \
  --rpc-url http://127.0.0.1:9545 \
  --private-key $PRIVATE_KEY
