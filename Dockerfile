FROM ubuntu:18.04


ENV DEBIAN_FRONTEND noninteractive
RUN apt update \
    && apt install -y --no-install-recommends software-properties-common curl apache2-utils \
    && apt update \
    && apt install -y --no-install-recommends \
        supervisor nginx sudo net-tools zenity xz-utils \
        dbus-x11 x11-utils alsa-utils \
        mesa-utils libgl1-mesa-dri \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*


RUN apt update \
    && apt install -y --no-install-recommends \
        xvfb \
        x11vnc \
        vim-tiny \
        firefox \
        chromium-browser \
        ttf-ubuntu-font-family


RUN apt update \
    && apt install -y --no-install-recommends \
        lxqt \
        openbox \
        gtk2-engines-murrine \
        gnome-themes-standard \
        gtk2-engines-pixbuf \
        arc-theme

ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini-amd64 /bin/tini
RUN chmod +x /bin/tini

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  gnupg \
  patch

COPY root /
WORKDIR /root
ENV HOME=/home/ubuntu
ENV SHELL=/bin/bash
HEALTHCHECK --interval=30s --timeout=5s CMD curl --fail http://127.0.0.1:6079/api/health
ENTRYPOINT ["/startup.sh"]
