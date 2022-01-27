#!/bin/bash

# Creation Date: 26/01/2022
# Author: Vinicius de Moraes Pacheco
# E-mail: vinicius.mpacheco@hotmail.com
# Remote Rrepository: https://github.com/viniciusmpacheco/automation/
# Description: Do standard installation and configuration of Git on a Linux machine
# Run Information: Preferably, must run on a machine where Git is not installed, so there are no installation conflicts. If installed on machines that already have Git, the old version will be uninstalled and replaced with the newer one, and all of existents old Git files or directories, or what else configuration will be deleted.
# Log Directory:
# Use Exemples: 
#       ./automation/config/tool/git-install.sh

# Imports
# ----------------------------------------------------------------------------------------------------------------

# Variáveis
# ----------------------------------------------------------------------------------------------------------------

# Functions
# ----------------------------------------------------------------------------------------------------------------

function main(){
    # Removing previous versions of Git
    echo "Removing previous versions of Git"
    desinstalarVersoesAntigasDoGit

    # Installing latest version of Git
    echo "Installing latest version of Git"
    instalarGit
}
function desinstalarVersoesAntigasDoGit(){
    # Purging Git
    echo "Purging Git"
    apt-get update
    apt-get remove git
    apt-get remove --auto-remove git
    apt-get purge git
    apt-get purge --auto-remove git
}

function instalarGit(){
    # Installing latest version of Git
    echo "Installing latest version of Git"
    apt-get update
    apt-get install git-all
}

# Execution
# ----------------------------------------------------------------------------------------------------------------

main