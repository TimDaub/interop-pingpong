#!/bin/bash

# Deployed contract addresses
CONTRACT_A="0x0165878A594ca255338adfa4d48449f69242Eb8F"
CONTRACT_B="0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512"
PRIVATE_KEY="0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"

# Hit ball from Chain B (902) to Chain A (901)
echo "Hitting ball from Chain B to Chain A:"
cast send $CONTRACT_B "hitBallTo(uint256)" 901 \
  --rpc-url http://127.0.0.1:9546 \
  --private-key $PRIVATE_KEY
