#!/usr/bin/env bash

#/usr/sbin/sshd -D &
service ssh start
python -m http.server 8000 --bind 0.0.0.0