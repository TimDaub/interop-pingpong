# CrossChain PingPong

A demonstration of Optimism's L2-to-L2 cross-chain messaging using two OP chains in a SuperSim environment. This project implements a simple "ping pong" game where a virtual ball is sent back and forth between two OP chains.

This project is based on the [SuperSim Cross-chain Contract Calls tutorial](https://supersim.pages.dev/guides/interop/cross-chain-contract-calls-pingpong), but has been isolated and simplified to focus purely on the cross-chain messaging functionality.

## Overview

This project demonstrates:
- L2-to-L2 direct messaging between Optimism chains
- Using [SuperSim](https://supersim.pages.dev/) to run a local OP Stack devnet
- Deterministic deployments using CREATE2
- Cross-chain communication via the L2ToL2CrossDomainMessenger

## Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- [SuperSim](https://supersim.pages.dev/)

## Setup Instructions

1. Start SuperSim with auto-relay enabled:

```bash
supersim --interop.autorelay
```

This will launch two OP chains with the following configuration:
- OPChainA: Chain ID 901, port 9545
- OPChainB: Chain ID 902, port 9546
- Available accounts, with the first account (used for deployment) having private key `0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80`

2. Deploy the contracts to both chains:

```bash
./deploy.sh
```

The deploy script will:
- Create identical contracts on both chain 901 and chain 902 at the same address (using CREATE2)
- Initialize chain 901 with the ball (as specified in the constructor)

Successful deployment will look like:

```
Deploying to OPChainA (Chain ID 901)...
[⠊] Compiling...
No files changed, compilation skipped
Script ran successfully.

== Logs ==
  Deployed at:  0xEFd7B7eCD385EdB10311Deeb760b433E215d101A

## Setting up 1 EVM.

==========================

Chain 901

... (deployment details)

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.

Deploying to OPChainB (Chain ID 902)...
[⠊] Compiling...
No files changed, compilation skipped
Script ran successfully.

== Logs ==
  Deployed at:  0xEFd7B7eCD385EdB10311Deeb760b433E215d101A

## Setting up 1 EVM.

==========================

Chain 902

... (deployment details)

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
```

**Note:** Deployment can only happen once per SuperSim session as the CREATE2 addresses will already exist on subsequent attempts. If you need to redeploy, restart SuperSim.

## Using the PingPong Game

### Check Ball Location

To check where the ball is currently located:

```bash
./check.sh
```

Initial state should show the ball on OPChainA (901):

```
Checking ball on OPChainA (901):
1
901
0x4e59b44847b379578588920cA78FbF26c0B4956C  # Address may vary

Checking ball on OPChainB (902):
0
0
0x0000000000000000000000000000000000000000
```

### Hit Ball to Chain B

To hit the ball from Chain A to Chain B:

```bash
./hit.sh
```

You should see transaction details and in the SuperSim logs, you'll see messages like:

```
INFO [timestamp] L2ToL2CrossChainMessenger#SentMessage    sourceChainID=901 destinationChainID=902 ...
INFO [timestamp] L2ToL2CrossChainMessenger#RelayedMessage sourceChainID=901 destinationChainID=902 ...
```

### Check Ball Again

After hitting the ball to Chain B, check its location:

```bash
./check.sh
```

You should now see:

```
Checking ball on OPChainA (901):
0
0
0x0000000000000000000000000000000000000000

Checking ball on OPChainB (902):
2
901
0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266  # Address of player who hit the ball
```

### Hit Ball Back to Chain A

To hit the ball from Chain B back to Chain A:

```bash
./hitback.sh
```

After hitting the ball back, check its location again:

```bash
./check.sh
```

You should see:

```
Checking ball on OPChainA (901):
3
902
0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266  # Address of player who hit the ball

Checking ball on OPChainB (902):
0
0
0x0000000000000000000000000000000000000000
```

## How It Works

1. **Contract Deployment:**
   - The same contract is deployed to two different OP chains at the same address using CREATE2
   - The deployment script specifies chain 901 as the "server chain" that starts with the ball

2. **Cross-Chain Messaging:**
   - When a user calls `hitBallTo()`, the contract:
     - Increments the rally count
     - Records the sender's address and chain ID
     - Clears the ball from the current chain
     - Sends a cross-chain message to the destination chain using the L2ToL2CrossDomainMessenger

3. **Message Relay:**
   - SuperSim's auto-relay functionality automatically relays the message to the destination chain
   - The destination contract receives the ball via the `receiveBall()` function
   - The ball is now on the destination chain and can be hit back

4. **Ball State:**
   - The ball's state includes:
     - `rallyCount`: How many times the ball has been hit
     - `lastHitterChainId`: The chain ID where the ball was last hit
     - `lastHitterAddress`: The address of the last player to hit the ball

## Technical Details

### Contract Address

Both contracts are deployed to the same address on different chains through CREATE2, using the same salt value:

```solidity
CrossChainPingPong game = new CrossChainPingPong{salt: "pingpong"}(901);
```

### Message Authentication

The contract includes safeguards to ensure messages come from valid sources:

```solidity
modifier onlyCrossDomainCallback() {
    if (msg.sender != address(messenger)) revert CallerNotL2ToL2CrossDomainMessenger();
    if (messenger.crossDomainMessageSender() != address(this)) revert InvalidCrossDomainSender();
    _;
}
```

## Troubleshooting

- **Deployment Fails**: If you see revert errors during deployment, it's likely because the contracts have already been deployed. Restart SuperSim to reset the chains.
- **Ball Not Moving**: Ensure SuperSim's auto-relay is enabled with the `--interop.autorelay` flag.
- **Script Permissions**: If scripts don't run, ensure they have executable permissions: `chmod +x *.sh`
