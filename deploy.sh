#!/bin/bash

# Define private key for deployment (using the first account from Supersim)
PRIVATE_KEY="0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"

# Deploy to chain 901 (OPChainA)
echo "Deploying to OPChainA (Chain ID 901)..."
forge create --broadcast src/CrossChainPingPong.sol:CrossChainPingPong \
  --rpc-url http://127.0.0.1:9545 \
  --private-key $PRIVATE_KEY \
  --constructor-args 901

# Deploy to chain 902 (OPChainB)
echo "Deploying to OPChainB (Chain ID 902)..."
forge create --broadcast src/CrossChainPingPong.sol:CrossChainPingPong \
  --rpc-url http://127.0.0.1:9546 \
  --private-key $PRIVATE_KEY \
  --constructor-args 902
