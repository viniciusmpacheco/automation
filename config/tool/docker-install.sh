#!/bin/bash

# Creation Date: 19/01/2022
# Author: Vinicius de Moraes Pacheco
# E-mail: vinicius.mpacheco@hotmail.com
# Remote Rrepository: https://github.com/viniciusmpacheco/automation/
# Description: Do standard installation and configuration of Docker on a Linux machine
# Run Information: Preferably, must run on a machine where Docker is not installed, so there are no installation conflicts.If installed on machines that already have Docker, the old version will be uninstalled and replaced with the newer one, and all of existents old docker files or directories, or what else configuration will be deleted.
# Log Directory:
# Use Exemples: 
#       ./automation/config/tool/docker-install.sh

# Imports
# ----------------------------------------------------------------------------------------------------------------
source ../../helpers/logger.sh

# Variáveis
# ----------------------------------------------------------------------------------------------------------------

DOCKER_DOWNLOAD_URL="https://download.docker.com/linux/ubuntu"
GPG_KEY_DOWNLOAD_URL="$DOCKER_DOWNLOAD_URL/gpg"
GPG_KEY_DIRECTORY="/usr/share/keyrings/docker-archive-keyring.gpg"

# Functions
# ----------------------------------------------------------------------------------------------------------------

function main(){
    echo "Uninstall old versions of Docker Engine"
    desinstalarVersoesAntigasDoDocker

    echo "Preconfigurin Docker dependencies"
    preConfigurarDependenciasDoDocker

    echo "Install latest version of Docker Engine"
    instalarDocker
}

function desinstalarVersoesAntigasDoDocker(){
    # Removing old versions of Docker Engine
    echo "Removing old versions of Docker Engine"
    apt-get remove docker docker-engine docker.io containerd runc
    apt-get purge docker-ce docker-ce-cli containerd.io -y

    # Removing files, directories and settings from old versions of Docker
    echo "Removing files, directories and settings from old versions of Docker"
    rm -rf /var/lib/docker
    rm -rf /var/lib/containerd
}

function preConfigurarDependenciasDoDocker(){
    # Update the apt package index and install packages to allow apt to use a repository over HTTPS
    echo "Update the apt package index and install packages to allow apt to use a repository over HTTPS"
    apt-get update
    apt-get install ca-certificates curl gnupg lsb-release -y

    # Add Docker’s official GPG key
    echo "Add Docker’s official GPG key"
    curl -fsSL $GPG_KEY_DOWNLOAD_URL | sudo gpg --dearmor -o $GPG_KEY_DIRECTORY

    # Set up the stable repository
    echo "Set up the stable repository"
    echo "deb [arch=$(dpkg --print-architecture) signed-by=$GPG_KEY_DIRECTORY] $DOCKER_DOWNLOAD_URL $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
}

function instalarDocker(){
    # Update the apt package index, and install the latest version of Docker Engine and containerd
    echo "Update the apt package index, and install the latest version of Docker Engine and containerd"
    apt-get update
    apt-get install docker-ce docker-ce-cli containerd.io -y
}

# Execution
# ----------------------------------------------------------------------------------------------------------------

main