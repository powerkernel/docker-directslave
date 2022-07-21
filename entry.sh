#!/usr/bin/env bash

if [ -f "/usr/local/directslave/etc/passwd" ]; then
    echo "/usr/local/directslave/etc/passwd exists. Skipping"
else 
    echo "/usr/local/directslave/etc/passwd does not exist. Creating"
    touch /usr/local/directslave/etc/passwd
    chown -R bind:bind /usr/local/directslave/etc/passwd
    /usr/local/directslave/bin/directslave-linux-amd64 --password $USER:$PASSWD
fi

# run supervisord
/usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf