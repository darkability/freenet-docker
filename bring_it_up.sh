#!/bin/bash
export TAG=1470
export SIZE=4gb

# Fill file with digitalocean key + region
source credentials.sh

make -f digitalocean.makefile machine && \
eval "$(make -f digitalocean.makefile env-cmd)" && \
make -f digitalocean.makefile deploy && \
make -f digitalocean.makefile tunnel
