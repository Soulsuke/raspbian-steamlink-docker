### Kept for reference: starting off from regularm debian buster.
###############################################################################
#
## Start from the right debian image:
#FROM arm32v7/debian:buster
#
## Update the image, and install some essential packages:
#RUN apt -y update && \
#    apt -y upgrade && \
#    apt -y install \
#      gnupg2 \
#      zenity
#
## Replace debian sources with raspbian ones:
#RUN echo "deb http://raspbian.raspberrypi.org/raspbian/ buster main contrib non-free rpi" > /etc/apt/sources.list && \
#    echo "deb http://archive.raspberrypi.org/debian/ buster main" >> /etc/apt/sources.list
#
## Add the relative keys:
#RUN apt-key adv --fetch-keys https://archive.raspbian.org/raspbian.public.key && \
#    apt-key adv --fetch-keys https://archive.raspberrypi.org/debian/raspberrypi.gpg.key

# Start from the right raspbian image:
FROM resin/rpi-raspbian:buster

# Avoid any interactive prompts:
ENV DEBIAN_FRONTEND=noninteractive

# Update the system:
RUN apt -y update
RUN apt -y upgrade

# Install essential packages:
RUN apt -y install \
      bash \
      curl \
      gnupg2 \
      libevdev2:armhf \
      libglib2.0-0:armhf \
      libgudev-1.0-0:armhf \
      libinput10:armhf \
      libjpeg62-turbo:armhf \
      libmtdev1:armhf \
      libraspberrypi0:armhf \
      libusb-1.0-0:armhf \
      libwacom2:armhf \
      libxcb-xkb1:armhf \
      libxkbcommon-x11-0:armhf \
      libxkbcommon0:armhf \
      net-tools \
      python3 \
      sudo \
      xz-utils \
      zenity

# These are the dependencies installed by steamlink's dependencies helper.
# Taken from ~/.local/share/SteamLink/steamlinkdeps.txt
# I doubt they're gonna change anytime soon, so let's install them:
RUN apt install -y \
      cec-utils \
      libavcodec58:armhf \
      libc6:armhf \
      libdbus-1-3:armhf \
      libegl1:armhf \
      libfontconfig1:armhf \
      libgbm1:armhf \
      libgcc1:armhf \
      libgl1-mesa-dri:armhf \
      libgles2:armhf \
      libglib2.0-0:armhf \
      libinput10:armhf \
      libjpeg62-turbo:armhf \
      libpng16-16:armhf \
      libpulse0:armhf \
      libraspberrypi0:armhf \
      libstdc++6:armhf \
      libudev1:armhf \
      libusb-1.0-0:armhf \
      libx11-6:armhf \
      libx11-xcb1:armhf \
      libxcb1:armhf \
      libxext6:armhf \
      libxkbcommon-x11-0:armhf \
      libxkbcommon0:armhf \
      openssl \
      zlib1g:armhf

# DEB file name (to avoid typos):
ARG deb="steamlink.deb"

# Fetch the package from Valve:
RUN curl https://media.steampowered.com/steamlink/rpi/latest/${deb} -o ${deb}

# Install it (exit 0 needed as dpkg may complain about missing dependencies):
RUN dpkg -i ${deb}; exit 0

# Fix any missing dependencies:
RUN apt install -f -y

# These settings are written on steamlink startup if not already present.
# Taken from: ~/.local/share/SteamLink/udev
# Write them over to avoid issues:
COPY udev/modules-load.d/uinput.conf /etc/modules-load.d/uinput.conf
COPY udev/rules.d/56-steamlink.rules /lib/udev/rules.d/56-steamlink.rules

# User who will run steamlink (to avoid typos):
ARG sl_user="steamlink"

# Add the user:
RUN useradd -m -s /usr/bin/bash ${sl_user}

# Add it to the default groups so everything can work:
ARG groups="audio dialout games gpio input netdev plugdev spi users video"
RUN for g in ${groups}; do usermod -a -G ${g} ${sl_user}; done

# Make it able to run sudo commands without password:
#RUN echo "${sl_user} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# Switch to it for everything that comes up next:
USER ${sl_user}

# Ensure this folder exists, nothing more:
RUN mkdir -p /home/${sl_user}/.local/share/SteamLink

# Run steamlink:
ENTRYPOINT steamlink

