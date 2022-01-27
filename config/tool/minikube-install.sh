#!/bin/bash

# Creation Date: 26/01/2022
# Author: Vinicius de Moraes Pacheco
# E-mail: vinicius.mpacheco@hotmail.com
# Remote Rrepository: https://github.com/viniciusmpacheco/automation/
# Description: Do standard installation and configuration of Minikube on a Linux machine
# Run Information: Preferably, must run on a machine where Minikube is not installed, so there are no installation conflicts. If installed on machines that already have Minikube, the old version will be uninstalled and replaced with the newer one, and all of existents old Minikube files or directories, or what else configuration will be deleted.
# Log Directory:
# Use Exemples: 
#       ./automation/config/tool/minikube-install.sh

# Imports
# ----------------------------------------------------------------------------------------------------------------

# Variáveis
# ----------------------------------------------------------------------------------------------------------------

MINKUBE_GOOGLE_REPOSITORY_URL="https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64"

# Functions
# ----------------------------------------------------------------------------------------------------------------

function main(){
    # Removing previous versions of Minikube
    echo "Removing previous versions of Minikube"
    desinstalarVersoesAntigasDoMinikube

    # Installing latest version of Minikube
    echo "Installing latest version of Minikube"
    instalarMinikube
}

function desinstalarVersoesAntigasDoMinikube(){
    # Stops and removes minikube-initiated clusters
    minikube stop; minikube delete
    # Stops running docker containers
    docker stop (docker ps -aq)
    # Removing minikube related files, directories and processes
    rm -r ~/.kube ~/.minikube
    sudo rm /usr/local/bin/localkube /usr/local/bin/minikube
    systemctl stop '*kubelet*.mount'
    sudo rm -rf /etc/kubernetes/
    docker system prune -af --volumes
}

function instalarMinikube(){
    # Install the latest minikube stable release on Linux using binary download
    echo "Install the latest minikube stable release on Linux using binary download"
    curl -LO $MINKUBE_GOOGLE_REPOSITORY_URL
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
}

# Execution
# ----------------------------------------------------------------------------------------------------------------

main