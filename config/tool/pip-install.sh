#!/bin/bash

# Creation Date: 03/02/2022
# Author: Lucas Moraes da Silva
# E-mail: lucasmoraessilva01@gmail.com
# Remote Rrepository: https://github.com/viniciusmpacheco/automation/
# Description: Installs the latest LTS version of Pip.
# Run Information: Through the package manager, pip3 is installed to manage Python packages.
# Log Directory:
# Use Exemples: 
#       ./automation/config/tool/pip-install.sh

# Imports
# ----------------------------------------------------------------------------------------------------------------

# Variáveis
# ----------------------------------------------------------------------------------------------------------------

# Functions
# ----------------------------------------------------------------------------------------------------------------

function main(){
    # Remove old versions of Pip
    echo "Remove old versions of Pip"
    removerVersoesAntigasDoPip

    # Install Pip
    echo "Install Pip"
    instalarPip
}

function removerVersoesAntigasDoPip(){
    # Remove old versions of Pip and their dependencies
    echo "Remove old versions of Pip and their dependencies"
    apt-get remove --auto-remove -y python*pip
    apt-get purge --auto-remove -y python*pip
}

function instalarPip(){
    # Install latest version of Pip 
    echo "Install latest version of Pip"
    apt-get install -y python3-pip
}

# Execution
# ----------------------------------------------------------------------------------------------------------------

main
