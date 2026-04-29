#!/usr/bin/env bash
HOST_GID=$(id -g)

mkdir -p \
  opencode/config/pilot \
  opencode/share \
  opencode/state \
  opencode/agents

sudo chown -R 61100:"$HOST_GID" opencode
sudo chmod -R 775 opencode