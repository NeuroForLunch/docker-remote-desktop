
FROM ubuntu:18.04


ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -yq --no-install-recommends \
    oftware-properties-common \
    curl \
    apache2-utils \
    && apt update \
    && apt install -y --no-install-recommends \
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



RUN apt update \
    && apt install -y --no-install-recommends \
        xvfb \
        x11vnc=0.9.16-1 \
        vim-tiny \
        firefox \
        ttf-ubuntu-font-family


RUN apt update \
    && apt install -y --no-install-recommends \
        lxde \
        gtk2-engines-murrine \
        gnome-themes-standard \
        gtk2-engines-pixbuf \
        gtk2-engines-murrine \
        arc-theme \
        ca-certificates \
        gnupg \
        patch


ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /bin/tini
RUN chmod +x /bin/tini


COPY root /

WORKDIR /root
ENV HOME=/home/ubuntu \
    SHELL=/bin/bash
HEALTHCHECK --interval=30s --timeout=5s CMD curl --fail http://127.0.0.1:6079/api/health
ENTRYPOINT ["/startup.sh"]
