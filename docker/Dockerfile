# Start from the right debian image:
FROM arm32v7/debian:buster

# Avoid any interactive prompts:
ENV DEBIAN_FRONTEND=noninteractive

# Update the image, and install some essential packages:
RUN apt -y update && \
    apt -y upgrade && \
    apt -y install \
      gnupg2 \
      zenity

# Replace debian sources with raspbian ones:
RUN echo "deb http://raspbian.raspberrypi.org/raspbian/ buster main contrib non-free rpi" > /etc/apt/sources.list && \
    echo "deb http://archive.raspberrypi.org/debian/ buster main" >> /etc/apt/sources.list

# Add the relative keys:
RUN apt-key adv --fetch-keys https://archive.raspbian.org/raspbian.public.key && \
    apt-key adv --fetch-keys https://archive.raspberrypi.org/debian/raspberrypi.gpg.key

# Update, upgrade, and install some needed packages:
RUN apt -y update && \
    apt -y upgrade && \
    apt -y install \
      bash \
      curl \
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
      libxkbcommon0:armhf \
      libxkbcommon-x11-0:armhf \
      net-tools \
      python3 \
      sudo \
      xz-utils

# These are the dependencies installed by steamlink's dependencies helper.
# I doubt they're gonna change anytime soon, so let's install them:
RUN apt install -y \
      cec-utils \
      openssl \
      libavcodec58:armhf \
      libc6:armhf \
      libdbus-1-3:armhf \
      libegl1:armhf \
      libfontconfig1:armhf \
      libgbm1:armhf \
      libgcc1:armhf \
      libglib2.0-0:armhf \
      libgl1-mesa-dri:armhf \
      libgles2:armhf \
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
      zlib1g:armhf

# Fetch and install the steamlink package from valve:
RUN curl https://media.steampowered.com/steamlink/rpi/latest/steamlink.deb -o steamlink.deb && \
    dpkg -i steamlink.deb; exit 0

# Now fix its missing dependencies:
RUN apt install -f -y

# User who will run steamlink:
ARG sl_user="steamlink"

# Add the user:
RUN useradd -m -s /usr/bin/bash ${sl_user}

# Add it to the default raspbian groups so everything can work:
ARG groups="dialout audio video plugdev games users input netdev gpio spi"
RUN for g in ${groups[@]}; do groupadd ${g} ; usermod -a -G ${g} ${sl_user}; done

# Make it able to run sudo commands without password:
#RUN echo "${sl_user} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# And switch to it:
USER ${sl_user}

# Make steamlink skip wayland and cpu checks:
RUN mkdir -p /home/${sl_user}/.local/share/SteamLink

# Run steamlink:
ENTRYPOINT steamlink

