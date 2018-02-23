#!/bin/sh

if [ -n "${VNC_PASSWORD}" ]; then
    echo -n "${VNC_PASSWORD}" > /.password1
    x11vnc -storepasswd $(cat /.password1) /.password2
    chmod 400 /.password*
    sed -i 's/^command=x11vnc.*/& -rfbauth \/.password2/' /etc/supervisor/conf.d/x11vnc.conf
    export VNC_PASSWORD=
fi

exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf