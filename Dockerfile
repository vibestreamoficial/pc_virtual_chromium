FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6080 \
    VNC_PASSWORD=pcvirtual \
    RESOLUTION=1280x720 \
    HOME=/root

RUN apt-get update && apt-get install -y --no-install-recommends \
    xfce4 xfce4-terminal \
    tigervnc-standalone-server tigervnc-common \
    novnc websockify \
    chromium-browser \
    dbus-x11 \
    fonts-liberation fonts-noto-core \
    ca-certificates curl wget unzip \
    supervisor \
    locales \
    && locale-gen pt_BR.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# Chromium no Ubuntu 22.04 às vezes é snap-stub; garante binário
RUN if [ ! -x /usr/bin/chromium-browser ] && [ -x /usr/bin/chromium ]; then \
      ln -sf /usr/bin/chromium /usr/bin/chromium-browser; \
    fi; \
    if ! command -v chromium-browser >/dev/null 2>&1 && ! command -v chromium >/dev/null 2>&1; then \
      apt-get update && apt-get install -y --no-install-recommends chromium || true; \
      rm -rf /var/lib/apt/lists/*; \
    fi

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 6080 5901

CMD ["/usr/local/bin/start.sh"]
