#!/bin/bash
sudo apt update
git clone -b monolith https://github.com/express42/reddit.git /usr/puma
cd /usr/puma && bundle install
puma -d
