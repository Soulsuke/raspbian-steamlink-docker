#! /usr/bin/env bash

SLINK="~/.local/share/SteamLink"

# Create the main folder:
mkdir -p ${SLINK}

# These are to avoid certain checks:
files=(
  .ignore_cpuinfo
  .ignore_x11
)
for f in ${files[*]}; do
  touch "${SLINK}/${f}"
done

# Finally, run the docker image binding this folder:
# TODO: --volume ${SLINK}:/home/steamlink/.local/share/SteamLink

