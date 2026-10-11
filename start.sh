#!/usr/bin/env bash
set -euo pipefail

export DISPLAY=:1
PASS="${VNC_PASSWORD:-pcvirtual}"
RES="${RESOLUTION:-1280x720}"

mkdir -p "$HOME/.vnc"

# senha VNC
echo "$PASS" | vncpasswd -f > "$HOME/.vnc/passwd"
chmod 600 "$HOME/.vnc/passwd"

# xstartup XFCE
cat > "$HOME/.vnc/xstartup" << 'XEOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
export XKL_XMODMAP_DISABLE=1
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
exec startxfce4
XEOF
chmod +x "$HOME/.vnc/xstartup"

# mata sessao antiga se existir
vncserver -kill :1 >/dev/null 2>&1 || true
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1 2>/dev/null || true

vncserver :1 -geometry "$RES" -depth 24 -localhost no

# noVNC
websockify --web=/usr/share/novnc/ 6080 localhost:5901 &

echo "============================================"
echo " PC Virtual UP"
echo " noVNC: http://localhost:6080/vnc.html"
echo " Senha VNC: $PASS"
echo "============================================"

# mantem container vivo
tail -f /dev/null
