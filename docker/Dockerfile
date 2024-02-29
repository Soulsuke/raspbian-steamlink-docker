# Start from a raspbian buster image:
FROM resin/rpi-raspbian:buster

# Avoid any interactive prompts:
ENV DEBIAN_FRONTEND=noninteractive

# Update the system:
RUN apt update -y
RUN apt upgrade -y

# Install essential packages:
RUN apt install -y \
      bash \
      alsa-utils \
      curl \
      gnupg2 \
      libevdev2 \
      libglib2.0-0 \
      libgudev-1.0-0 \
      libinput10 \
      libjpeg62-turbo \
      libmtdev1 \
      libraspberrypi-bin \
      libraspberrypi-dev \
      libraspberrypi-doc \
      libraspberrypi0 \
      libsdl2-2.0-0 \
      libsdl2-image-2.0-0 \
      libsdl2-mixer-2.0-0 \
      libsdl2-ttf-2.0-0 \
      libusb-1.0-0 \
      libwacom2 \
      libxcb-xkb1 \
      libxkbcommon-x11-0 \
      libxkbcommon0 \
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
      libavcodec58 \
      libc6 \
      libdbus-1-3 \
      libegl1 \
      libfontconfig1 \
      libgbm1 \
      libgcc1 \
      libgl1-mesa-dri \
      libgles2 \
      libglib2.0-0 \
      libinput10 \
      libjpeg62-turbo \
      libpng16-16 \
      libpulse0 \
      libraspberrypi0 \
      libstdc++6 \
      libudev1 \
      libusb-1.0-0 \
      libx11-6 \
      libx11-xcb1 \
      libxcb1 \
      libxext6 \
      libxkbcommon-x11-0 \
      libxkbcommon0 \
      openssl \
      zlib1g

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

# Add in a pulseaudio workaround:
COPY pulse-client.conf /etc/pulse/client.conf

# User who will run steamlink (to avoid typos):
ARG sl_user="steamlink"

# Add the user:
RUN useradd -m -s /usr/bin/bash ${sl_user}

# Add it to the default groups so everything can work:
ARG groups="audio dialout games gpio input netdev plugdev spi users video"
RUN for g in ${groups}; do groupadd ${h} ; usermod -a -G ${g} ${sl_user}; done

# Make it able to run sudo commands without password, so the deps script will
# not print out any error:
RUN echo "${sl_user} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# Switch to it for everything that comes up next:
USER ${sl_user}

# Ensure these folders exists, nothing more:
RUN mkdir -p "/home/${sl_user}/.config/Valve Corporation"
RUN mkdir -p "/home/${sl_user}/.local/share/SteamLink"
RUN mkdir -p "/home/${sl_user}/.local/share/Valve Corporation"

# Run steamlink:
ENTRYPOINT steamlink

