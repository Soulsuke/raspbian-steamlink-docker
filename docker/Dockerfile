# Start from the right debian image:
FROM arm32v7/debian:buster

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

# Update, upgrade, install new packages:
RUN apt -y update && \
    apt -y upgrade && \
    apt -y install \
      xterm \
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
      xz-utils \
      bash

# Fetch and install the steamlink package from valve:
RUN curl https://media.steampowered.com/steamlink/rpi/latest/steamlink.deb -o steamlink.deb && \
    dpkg -i steamlink.deb; exit 0

# Now, fix steamlink's dependencies:
RUN apt install -f -y



# WORKAROUND BELOW!!!!
# These are dependencies usually installed by steamlinkdeps.
# Since they require root privileges, I'd rather to install them manually now.
# Later on, if everything works, it may be worth to add the user to sudoers
# so it can install them at the right time.
# NOTES:
#  66 -> libgcc1:armhf | libgcc-s1:armhf
#  75 -> libraspberrypi0:armhf | rbp-userland-osmc:armhf
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
# WORKAROUND ABOVE!!!



# Add a steamlink user:
RUN useradd -m -s /usr/bin/bash steamlink

# And switch to it:
USER steamlink

# Make steamlink skip wayland and cpu checks:
RUN mkdir -p /home/steamlink/.local/share/SteamLink

# Run steamlink:
#CMD steamlink
ENTRYPOINT steamlink

