#!/usr/bin/env sh
set -eux

while [ ! -f /var/lib/cloud/instance/boot-finished ]; do
  sleep 1
done

sudo hostnamectl set-hostname web
sudo timedatectl set-timezone Asia/Tokyo

sudo apt-get update &&
  sudo apt-get upgrade -y &&
  sudo apt-get autoremove -y

sudo apt-get -y install default-mysql-client

sudo reboot
