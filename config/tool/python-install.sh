#!/bin/bash

# Creation Date: 31/01/2022
# Author: Lucas Moraes da Silva
# E-mail: lucasmoraessilva01@gmail.com
# Remote Rrepository: https://github.com/viniciusmpacheco/automation/
# Description: Installs the latest LTS version Python.
# Run Information: .
# Log Directory:
# Use Exemples: 
#       ./automation/config/tool/node-install.sh

# Imports
# ----------------------------------------------------------------------------------------------------------------

# Variáveis
# ----------------------------------------------------------------------------------------------------------------

# Functions
# ----------------------------------------------------------------------------------------------------------------

function main(){
    # Remove old versions of Python
    echo "Remove old versions of Python"
    removerVersoesAntigasDoPython

    # Pre-configure Python dependencies
    echo "Pre-configure Python dependencies"
    preConfigurarDependenciasDoPython

    # Install Python
    echo "Install Python"
    instalarPython
}

function removerVersoesAntigasDoPython(){
    # Remove old versions of Python and their dependencies
    echo "Remove old versions of Python and their dependencies"
    apt-get remove --auto-remove -y python3*
    apt-get purge --auto-remove -y python3*
}

function preConfigurarDependenciasDoPython(){
    # Install Python dependencies
    echo "Install Python dependencies"
    apt-get update
    apt-get install -y software-properties-common
    
    # Add PPA for installation
    echo "Add PPA for installation"
    add-apt-repository -y ppa:deadsnakes/ppa
    apt-get update
}

function instalarPython(){
    # Install Python version 3.10 
    echo "Install Python version 3.10"
    apt-get install -y python3.10
}

# Execution
# ----------------------------------------------------------------------------------------------------------------

main
