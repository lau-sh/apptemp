#!/bin/bash

DOCKER_VERSION=v2.2.3

INSTALLATION_LIST=(
ca-certificates
curl
gnupg
lsb-release
python3
python3-pip
)

POST_INSTALLATION_LIST=(
containerd.io
docker-ce
docker-ce-cli
)

function SetupUbuntu() {
    DOCKER_KEYRING_PATH="/usr/share/keyrings/docker-archive-keyring.gpg"

    INSTALL_CMD="sudo apt update && sudo apt install -y"
    DOCKER_GPG_CMD="curl -fsSL https://download.docker.com/linux/ubuntu/gpg"
    ADD_KEYRING_CMD="sudo gpg --dearmor -o ${DOCKER_KEYRING_PATH}"

    ADD_SOURCE="echo \"deb [arch=$(dpkg --print-architecture)
                signed-by=${DOCKER_KEYRING_PATH}]
                https://download.docker.com/linux/ubuntu
                $(lsb_release -cs) stable\" |
                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null"
}

DISTRO=$(sudo grep -h "^ID=" /etc/*-release | cut -c4-)

if [ $? -ne 0 ]
then
    echo "sudo failed.  $0 requires elevated privileges.  Please try again."
    exit 1
fi

echo "Determining Linux distribution..."
case "${DISTRO}" in
    ubuntu)
        echo "Distribution ${DISTRO} found.  Installing required packages..."
        SetupUbuntu
        ;;
    *)
        echo "Unsupported distribution.  Please read README.md for more"
        exit 2
esac

echo "Installing Docker and its dependencies..."

eval -- ${INSTALL_CMD} ${INSTALLATION_LIST[*]}
eval -- "${DOCKER_GPG_CMD} | ${ADD_KEYRING_CMD}"
eval -- ${ADD_SOURCE}
eval -- ${INSTALL_CMD} ${POST_INSTALLATION_LIST[*]}
sudo usermod -aG docker ${USER}

if [ $? -ne 0 ]
then
    echo "Failed on installation step.  Check your apt package manager."
    exit 3
fi

echo "Installing docker-compose..."
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
DOCKER_PLUGIN=${DOCKER_CONFIG}/cli-plugins
DOCKER_LINK=https://github.com/docker/compose/releases/download/${DOCKER_VERSION}/docker-compose-linux-x86_64
DATA_PATH=/srv/data

mkdir -p ${DOCKER_PLUGIN}
curl -SL ${DOCKER_LINK} -o ${DOCKER_PLUGIN}/docker-compose
chmod +x ${DOCKER_PLUGIN}/docker-compose
sudo mkdir -p ${DATA_PATH}
sudo chgrp docker ${DATA_PATH} ${LOG_PATH}
sudo chmod g+w ${DATA_PATH} ${LOG_PATH}
cd ${DATA_PATH} && mkdir -p apptemp nginx/logs nginx/certs postgres
hash -r

if [ $? -ne 0 ]
then
    echo "Failed on installing docker-compose.  Check the URL of DOCKER_LINK."
    exit 4
fi

echo "Initialization successful!  Please re-login for installation to complete"
exit 0
