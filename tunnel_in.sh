#!/bin/bash

eval "$(make -f digitalocean.makefile env-cmd)" && \
make -f digitalocean.makefile tunnel
