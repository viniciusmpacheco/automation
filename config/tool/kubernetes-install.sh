#!/bin/bash

# Creation Date: 19/01/2022
# Author: Vinicius de Moraes Pacheco
# E-mail: vinicius.mpacheco@hotmail.com
# Remote Rrepository: https://github.com/viniciusmpacheco/automation/
# Description: Do standard installation and configuration of Kubernetes on a Linux machine
# Run Information: Preferably, must run on a machine where Kubernetes is not installed, so there are no installation conflicts.If installed on machines that already have Kubernetes, the old version will be uninstalled and replaced with the newer one, and all of existents old Kubernetes files or directories, or what else configuration will be deleted.
# Log Directory:
# Use Exemples: 
#       ./automation/config/tool/kubernetes-install.sh

# Imports
# ----------------------------------------------------------------------------------------------------------------

source ./minikube-install.sh

# Variables
# ----------------------------------------------------------------------------------------------------------------

# Functions
# ----------------------------------------------------------------------------------------------------------------

function main(){
    desinstalarVersoesAntigasDoKubernetes
    preConfigurarDependenciasDoKubernetes
    instalarKubernetes
}

function desinstalarVersoesAntigasDoKubernetes (){
    # Revert of changes made by kubeadm init or kubeadm join
    echo "Revert of changes made by kubeadm init or kubeadm join"
    kubeadm reset 
    # Deleting Kubernetes and its dependencies
    echo "Deleting Kubernetes and its dependencies"
    apt-get purge kubeadm kubectl kubelet kubernetes-cni kube* -y
    apt-get autoremove
    # Removing Kubernetes related directories and files
    echo "Removing Kubernetes related directories and files"
    rm -rf ~/.kube
}

function preConfigurarDependenciasDoKubernetes(){
    # Update the apt package index and install packages needed to use the Kubernetes apt repository
    echo "Update the apt package index and install packages needed to use the Kubernetes apt repository"
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl
    # Download the Google Cloud public signing key
    echo "Download the Google Cloud public signing key"
    curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
    # Add the Kubernetes apt repository
    echo "Add the Kubernetes apt repository"
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
}

function instalarKubernetes(){
    # Update apt package index with the new repository and install kubectl
    echo "Update apt package index with the new repository and install kubectl"
    apt-get update
    apt-get install -y kubectl
}

# Execution
# ----------------------------------------------------------------------------------------------------------------

main