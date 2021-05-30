FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y --no-install-recommends \
    software-properties-common \
    curl \
    apache2-utils \
    ca-certificates \
    gnupg \
    patch

RUN apt update && apt install -y --no-install-recommends \
        supervisor \
        sudo \
        net-tools \
        zenity \
        xz-utils \
        dbus-x11 \
        x11-utils \
        alsa-utils \
        mesa-utils \
        libgl1-mesa-dri



RUN apt update && apt install -y --no-install-recommends \
    xvfb \
    x11vnc \
    vim-tiny \
    firefox \
    ttf-ubuntu-font-family


RUN apt update && apt install -y --no-install-recommends \
        lxde \
        gtk2-engines-murrine \
        gnome-themes-standard \
        gtk2-engines-pixbuf \
        gtk2-engines-murrine \
        arc-theme


ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /bin/tini
RUN chmod +x /bin/tini

# ffmpeg
RUN apt update && apt install -y --no-install-recommends \
    ffmpeg \
    && mkdir /usr/local/ffmpeg \
    && ln -s /usr/bin/ffmpeg /usr/local/ffmpeg/ffmpeg

WORKDIR /root
ENV HOME=/home/ubuntu SHELL=/bin/bash
ENTRYPOINT ["/startup.sh"]
