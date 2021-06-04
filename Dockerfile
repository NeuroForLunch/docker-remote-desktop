FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -yq \
    software-properties-common

RUN apt-get update && apt-get install -yq \
        supervisor \
        nginx \
        sudo \
        net-tools \
        zenity \
        xz-utils \
        dbus-x11 \
        x11-utils \
        alsa-utils \
        mesa-utils \
        libgl1-mesa-dri

RUN apt-get update && apt-get install -yq \
        xvfb \
        x11vnc \
        vim-tiny \
        firefox \
        gpg-agent

RUN apt-get update && apt-get install -yq \
        lxqt \
        openbox \
        lxqt-themes \
        ca-certificates \
        gnupg \
        patch \
    && apt-get upgrade -y

ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini-amd64 /bin/tini
RUN chmod +x /bin/tini

COPY root /
WORKDIR /root
ENV HOME=/root
ENV SHELL=/bin/bash

ENTRYPOINT ["/startup.sh"]
