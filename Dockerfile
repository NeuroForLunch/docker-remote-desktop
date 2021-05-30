FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install \
    software-properties-common \
    curl \
    apache2-utils

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
        ttf-ubuntu-font-family \
        gpg-agent

RUN curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && (dpkg -i ./google-chrome-stable_current_amd64.deb || apt-get install -fy) \
    && curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add \
    && rm google-chrome-stable_current_amd64.deb \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -yq \
  lxqt \
  openbox \
  lxqt-themes
  curl \
  ca-certificates \
  gnupg \
  patch

ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini-amd64 /bin/tini
RUN chmod +x /bin/tini

COPY root /

WORKDIR /root

ENV HOME=/root
ENV SHELL=/bin/bash

ENTRYPOINT ["/startup.sh"]
