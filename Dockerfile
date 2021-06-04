FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    software-properties-common \
    ca-certificates \
    gnupg \
    patch

RUN apt-get install -y \
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
        lxde \
        gtk2-engines-murrine \
        gnome-themes-standard \
        gtk2-engines-pixbuf \
        gtk2-engines-murrine \
        arc-theme \
        synaptic \
     && apt-get remove -y \
        clipit \
        deluge \
     && apt-get update && apt-get upgrade -y


RUN apt-get install -y ffmpeg \
    && mkdir /usr/local/ffmpeg \
    && ln -s /usr/bin/ffmpeg /usr/local/ffmpeg/ffmpeg


ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /bin/tini
RUN chmod +x /bin/tini


COPY root /

WORKDIR /root
ENV HOME=/home/ubuntu
ENV SHELL=/bin/bash
ENTRYPOINT ["/startup.sh"]
