#!/usr/bin/env sh
set -eu

# SWARM_KEY="$(echo -e "/key/swarm/psk/1.0.0/\n/base16/\n`tr -dc 'a-f0-9' < /dev/urandom | head -c64`")"

# lazy init
if [ -z "$(ls -A $IPFS_PATH 2> /dev/null)" ]; then
  if [ -n "${SWARM_KEY:-}" ]; then
    echo "$SWARM_KEY" > "${IPFS_PATH}/swarm.key"
    unset SWARM_KEY
  else
    echo "received no SWARM_KEY"
    exit 1
  fi

  ipfs init
  ipfs bootstrap rm --all
  ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080
fi


export LIBP2P_FORCE_PNET=1

if [[ -z "$@" ]]; then
    exec ipfs daemon --migrate --enable-gc
else
    exec ipfs "$@"
fi
