FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:1 \
    VNC_PASSWORD=pcvirtual \
    RESOLUTION=1280x720 \
    HOME=/root \
    LANG=C.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
    xfce4 xfce4-terminal \
    tigervnc-standalone-server tigervnc-common \
    novnc websockify \
    dbus-x11 \
    fonts-liberation fonts-noto-core fonts-noto-color-emoji \
    ca-certificates curl wget gnupg \
    unzip zip \
    mousepad \
    && rm -rf /var/lib/apt/lists/*

# Google Chrome real (Chromium-based) — funciona no Docker sem snap
RUN wget -q -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt-get update \
    && apt-get install -y /tmp/chrome.deb || apt-get install -y -f \
    && rm -f /tmp/chrome.deb \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/bin/google-chrome-stable /usr/local/bin/chromium \
    && ln -sf /usr/bin/google-chrome-stable /usr/local/bin/chrome

# atalho no desktop
RUN mkdir -p /root/Desktop \
    && printf '%s\n' \
      '[Desktop Entry]' \
      'Version=1.0' \
      'Type=Application' \
      'Name=Chromium (Chrome)' \
      'Exec=google-chrome-stable --no-sandbox --disable-gpu --disable-dev-shm-usage' \
      'Icon=google-chrome' \
      'Terminal=false' \
      'Categories=Network;WebBrowser;' \
      > /root/Desktop/chrome.desktop \
    && chmod +x /root/Desktop/chrome.desktop

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 6080 5901

CMD ["/usr/local/bin/start.sh"]
