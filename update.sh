#!/usr/bin/env bash

# Update 14.04 to 16.04
apt update || echo
apt upgrade -y --force-yes || echo
apt install -y update-manager-core
do-release-upgrade -f DistUpgradeViewNonInteractive

# Update 16.04 to 18.04
apt update || echo
apt upgrade -y --force-yes || echo
do-release-upgrade -f DistUpgradeViewNonInteractive

# Update 18.04 to 20.04
apt update || echo
apt upgrade -y --force-yes || echo
do-release-upgrade -f DistUpgradeViewNonInteractive
apt remove -y usrmerge

# Update 20.04 to 22.04
apt update
apt upgrade -y \
    --allow-downgrades \
    --allow-remove-essential \
    --allow-change-held-packages
do-release-upgrade -f DistUpgradeViewNonInteractive || test $? -eq 1
apt remove -y usrmerge

# Install latest docker
for pkg in docker.io docker-doc docker-compose docker-compose-v2 \
    podman-docker containerd runc; do sudo apt-get remove $pkg; done
apt install -y curl
apt autoremove -y
curl -fsSL https://get.docker.com | sh
apt remove -y $(dpkg-query --show 'linux-modules-*' | cut -f1 | grep -v "$(uname -r)")
rm -rf \
    /tmp \
    /boot \
    /usr/lib/firmware \
    /usr/lib/jvm/java-8-openjdk-amd64 \
    /usr/share/doc \
    /usr/share/man
find /usr/share/locale \
    -mindepth 1 -maxdepth 1 \
    -not -name en \
    -execdir rm -rf {} +
mkdir /.docker
mkdir /tmp
mkdir /boot
mkdir -p /usr/lib/firmware
mkdir -p /usr/lib/jvm/java-8-openjdk-amd64
mkdir -p /usr/share/doc
mkdir -p /usr/share/man
chmod 777 \
    /.docker \
    /boot \
    /tmp \
    /usr/lib/firmware \
    /usr/lib/jvm/java-8-openjdk-amd64 \
    /usr/share/doc \
    /usr/share/man
