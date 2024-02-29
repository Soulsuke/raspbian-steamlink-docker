#! /usr/bin/env bash

# Paths used by steamlink app:
CONFIG=".config/Valve Corporation"
LOCAL_APP=".local/share/SteamLink"
LOCAL_CONFIG=".local/share/Valve Corporation"

# Host shorthands:
H_CONFIG="${HOME}/${CONFIG}"
H_LOCAL_APP="${HOME}/${LOCAL_APP}"
H_LOCAL_CONFIG="${HOME}/${LOCAL_CONFIG}"

# Docker shorthands:
D_HOME="/home/steamlink"
D_CONFIG="${D_HOME}/${CONFIG}"
D_LOCAL_APP="${D_HOME}/${LOCAL_APP}"
D_LOCAL_CONFIG="${D_HOME}/${LOCAL_CONFIG}"

# Create the host folders:
mkdir -p "${H_CONFIG}"
mkdir -p "${H_LOCAL_APP}"
mkdir -p "${H_LOCAL_CONFIG}"

# Avoid steamlink's startup checks:
touch "${H_LOCAL_APP}/.ignore_cpuinfo"
touch "${H_LOCAL_APP}/.ignore_x11"
touch "${H_LOCAL_APP}/.ignore_gpumem"
touch "${H_LOCAL_APP}/.ignore_cec"

# Finally, run the docker container.
# To set the right platform:
#   --platform=linux/arm/v7
# To use the host's X session:
#   --volume "${HOME}/.Xauthority:${D_HOME}/.Xauthority:rw" \
#   --network=host
#   --env="DISPLAY"
# To mount the right folders, so all user data stays on the host:
#   --volume "${H_CONFIG}:${D_CONFIG}:rw"
#   --volume "${H_LOCAL_APP}:${D_LOCAL_APP}:rw"
#   --volume "${H_LOCAL_CONFIG}:${D_LOCAL_CONFIG}:rw"
# To have the container access the needed devices:
#   --device=/dev/dri:/dev/dri
#   --device=/dev/vchiq:/dev/vchiq
#   --device=/dev/input:/dev/input
# To (hopefully) connect pulseaudio to the host:
#   --volume="/run/user/${UID}/pulse:/run/user/1000/pulse:rw"
docker run \
  --platform=linux/arm/v7 \
  --volume "${HOME}/.Xauthority:${D_HOME}/.Xauthority:rw" \
  --network=host \
  --env="DISPLAY" \
  --volume "${H_CONFIG}:${D_CONFIG}:rw" \
  --volume "${H_LOCAL_APP}:${D_LOCAL_APP}:rw" \
  --volume "${H_LOCAL_CONFIG}:${D_LOCAL_CONFIG}:rw" \
  --device=/dev/dri:/dev/dri \
  --device=/dev/vchiq:/dev/vchiq \
  --device=/dev/input:/dev/input \
  --volume="/run/user/${UID}/pulse:/run/user/1000/pulse:rw" \
  steamlink

