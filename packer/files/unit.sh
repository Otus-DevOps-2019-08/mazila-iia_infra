#!/bin/bash

touch /etc/systemd/system/puma.service

echo -e '[Unit]\nDescription=Puma HTTP Server\nAfter=network.target\n[Service]\nType=simple\nWorkingDirectory=/usr/puma\nExecStart=/usr/local/bin/puma\nRestart=always\n[Install]\nWantedBy=multi-user.target\n' >> /etc/systemd/system/puma.service
systemctl daemon-reload
systemctl enable puma.service
systemctl start puma.service
