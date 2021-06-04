FROM ubuntu:18.04


ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
       ca-certificates \
       software-properties-common \
    && apt-get install -y \
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


RUN apt-get install -y \
        xvfb \
        x11vnc \
        vim-tiny \
        firefox


RUN apt-get install -y \
        lxqt \
        openbox \
        gtk2-engines-murrine \
        gnome-themes-standard \
        gtk2-engines-pixbuf \
        arc-theme \
        gnupg \
        patch \
     && apt-get update \
     && apt-get upgrade -y

ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini-amd64 /bin/tini
RUN chmod +x /bin/tini

COPY root /
WORKDIR /root
ENV HOME=/home/ubuntu
ENV SHELL=/bin/bash
ENTRYPOINT ["/startup.sh"]
