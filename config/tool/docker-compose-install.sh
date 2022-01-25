#!/bin/bash

# Creation Date: 19/01/2022
# Author: Vinicius de Moraes Pacheco
# E-mail: vinicius.mpacheco@hotmail.com
# Remote Rrepository: https://github.com/viniciusmpacheco/automation/
# Description: Do standard installation and configuration of Docker-Compose on a Linux machine
# Run Information: Preferably, must run on a machine where Docker-Compose is not installed, so there are no installation conflicts.If installed on machines that already have Docker, the old version will be uninstalled and replaced with the newer one, and all of existents old docker files or directories, or what else configuration will be deleted.
# Log Directory:
# Use Exemples: 
#       ./automation/config/tool/docker-compose-install.sh

# Imports
# ----------------------------------------------------------------------------------------------------------------

# Variáveis
# ----------------------------------------------------------------------------------------------------------------

# Functions
# ----------------------------------------------------------------------------------------------------------------

function main(){
    echo "Uninstall old versions of Docker-Compose"
    desinstalarVersoesAntigasDoDockerCompose

    echo "Install latest version of Docker-Compose"
    instalarDockerCompose
}

function desinstalarVersoesAntigasDoDockerCompose(){
    # Removing old versions of Docker-Compose
    echo "Removing old versions of Docker-Compose"
    rm /usr/local/bin/docker-compose
}

function instalarDockerCompose(){
    # Download the current stable release of Docker-Compose
    echo "Download the current stable release of Docker-Compose"
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    # Apply executable permissions to the binary
    echo "Apply executable permissions to the binary"
    chmod +x /usr/local/bin/docker-compose
    if ! docker-compose --version
    then
        ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    fi
}

# Execution
# ----------------------------------------------------------------------------------------------------------------

main