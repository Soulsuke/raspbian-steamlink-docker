#! /usr/bin/env bash

SLINK="${HOME}/.local/share/SteamLink"

# Create the main folder:
mkdir -p ${SLINK}

# Avoid steamlink's startup checks:
touch "${SLINK}/.ignore_cpuinfo"
touch "${SLINK}/.ignore_x11"
touch "${SLINK}/.ignore_gpumem"
touch "${SLINK}/.ignore_cec"

# Finally, run the docker image binding this folder:
docker run \
  --volume ${SLINK}:/home/steamlink/.local/share/SteamLink \
  --privileged \
  steamlink

