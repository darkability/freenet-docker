# What is this?

I've taken the Freenet setup process and gotten it working on the java 8
official Docker image. There's still some rough edges that I may get around to
addressing but right now you should be conscious of:

- relies on host networking for correct network setup
- node.opennet.listenPort is always 28585
- node.listenPort is always 60332
- I'm mapping `/dev/urandom` of the host machine over `/dev/random`. This is
    terrible security practice. It's there because otherwise the node can take
    hours gathering enough entropy to start.

# Getting Started

### via makefile

Just type `make` to build and run locally. Customize by editing
`.development.env`

Via Compose:

Construct an env file that sets the following, all in bytes:

```sh
INPUT_BANDWIDTH
OUTPUT_BANDWIDTH
STORE_SIZE
```

Run:

`ENV_FILE=foo TAG=latest docker-compose -f docker-compose.yml up`

If running directly:

```sh
INPUT_BANDWIDTH=??? OUTPUT_BANDWIDTH=??? STORE_SIZE=??? \
  docker run --rm -it --net=host darkability/freenet
```

# Deploying to DigitalOcean

I've included `digitalocean.makefile` that includes several makefile tasks that
will help co-ordinate bringing up a docker machine and running the Freenet image
on it.

See `bring_it_up.sh` for the intended usage. Take care with `clean_it_up.sh` as
it assumes this is the only machine you will be running in your environment.

At a high level, the process of deployment is simply

1. Bring up a vagrant machine or re-use the existing one
2. Use docker-machine env to get your docker agent talking remotely
3. Bring up Freenet
4. Tunnel to the machine with port fowarding
