#!/bin/bash

# Deployed contract addresses
CONTRACT_A="0x8d393f51F715A8A55EB3D4F14b13c4E2AEbca1c6"
CONTRACT_B="0x8d393f51F715A8A55EB3D4F14b13c4E2AEbca1c6"
PRIVATE_KEY="0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"

# Hit ball from Chain A (901) to Chain B (902)
echo "Hitting ball from Chain A to Chain B:"
cast send $CONTRACT_A "hitBallTo(uint256)" 902 \
  --rpc-url http://127.0.0.1:9545 \
  --private-key $PRIVATE_KEY
