FROM kbase/kb-sdk:1.2.1

# Update 14.04 to 16.04
RUN apt update || echo
RUN apt upgrade -y --force-yes || echo
RUN apt install -y update-manager-core
RUN do-release-upgrade -f DistUpgradeViewNonInteractive

# Update 16.04 to 18.04
RUN apt update || echo
RUN apt upgrade -y --force-yes || echo
RUN do-release-upgrade -f DistUpgradeViewNonInteractive

# Update 18.04 to 20.04
RUN apt update || echo
RUN apt upgrade -y --force-yes || echo
RUN do-release-upgrade -f DistUpgradeViewNonInteractive
RUN apt remove -y usrmerge

# Update 20.04 to 22.04
RUN apt update
RUN apt upgrade -y \
    --allow-downgrades \
    --allow-remove-essential \
    --allow-change-held-packages
RUN do-release-upgrade -f DistUpgradeViewNonInteractive || test $? -eq 1
RUN apt remove -y usrmerge

# Install latest docker
RUN for pkg in docker.io docker-doc docker-compose docker-compose-v2 \
    podman-docker containerd runc; do sudo apt-get remove $pkg; done
RUN apt install -y curl
RUN curl -fsSL https://get.docker.com | sh
RUN mkdir /.docker && chmod 777 /.docker
