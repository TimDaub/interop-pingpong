#!/bin/bash
cd "$(dirname "$0")"
forge init --no-commit --no-git
forge install --no-commit ethereum-optimism/optimism@develop
