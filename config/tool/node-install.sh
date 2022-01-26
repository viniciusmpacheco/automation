#!/bin/bash

# Creation Date: 25/01/2022
# Author: Lucas Moraes da Silva
# E-mail: lucasmoraessilva01@gmail.com
# Remote Rrepository: https://github.com/viniciusmpacheco/automation/
# Description: Installs the latest LTS version of Node through a script officially available from Nodesource.
# Run Information: Run the machine preparation script provided and install Node in the latest LTS version. If the script has already been run before, the data entered will be deleted and updated information will be inserted automatically.
# Log Directory:
# Use Exemples: 
#       ./automation/config/tool/node-install.sh

# Imports
# ----------------------------------------------------------------------------------------------------------------

# Variáveis
# ----------------------------------------------------------------------------------------------------------------

NODE_SCRIPT_DOWNLOAD_URL="https://deb.nodesource.com/setup_lts.x"

# Functions
# ----------------------------------------------------------------------------------------------------------------

function main(){
    # Preconfiguring machine for Node installation
    echo "Preconfiguring machine for Node installation"
    executarScriptDePreConfiguracaoDoNode

    # Installing the latest LTS version of Node
    echo "Installing the latest LTS version of Node"
    instalarNode
}

function executarScriptDePreConfiguracaoDoNode(){
    # Getting script through URL and running it as super user in bash
    echo "Getting script through URL and running it as super user in bash"
    curl -fsSL $NODE_SCRIPT_DOWNLOAD_URL | sudo -E bash -
}

function instalarNode(){
    # Updating the apt package index and installing the latest LTS version of Node
    echo "Updating the apt package index and installing the latest LTS version of Node"
    apt-get update
    apt-get install -y nodejs
}

# Execution
# ----------------------------------------------------------------------------------------------------------------

main
