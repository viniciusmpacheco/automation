#!/bin/bash

# Creation Date: 26/01/2022
# Author: Lucas Moraes da Silva
# E-mail: lucasmoraessilva01@gmail.com
# Remote Rrepository: https://github.com/viniciusmpacheco/automation/
# Description: Installs the latest LTS version of Java on a Linux machine.
# Run Information: Uninstall Java OpenJdk versions and install latest LTS version of Java OpenJdk
# Log Directory:
# Use Exemples: 
#       ./automation/config/tool/node-install.sh

# Imports
# ----------------------------------------------------------------------------------------------------------------

# Variáveis
# ----------------------------------------------------------------------------------------------------------------

LATEST_LTS_JAVA_VERSION_URL="https://api.adoptopenjdk.net/v3/info/available_releases"
LATEST_LTS_JAVA_VERSION=""
JAVA_VARIABLES_FILE_PATH="/etc/profile.d/java.sh"

# Functions
# ----------------------------------------------------------------------------------------------------------------

function main(){
    # Uninstall old versions of Java
    echo "Uninstall old versions of Java"
    desinstalarVersoesAntigasDoJava

    # Preconfigurin Docker dependencies
    echo "Preconfigurin Docker dependencies"
    preConfigurarDependenciasDoJava
 
    # Installing latest LTS version of Java
    echo "Installing latest LTS version of Java"
    instalarJava

    # Post configure Java dependencies
    echo "Post configure Java dependencies"
    posConfigurarDependenciasDoJava
}

function desinstalarVersoesAntigasDoJava(){
    # Removing Java versions of OpenJdk
    echo "Removing Java versions of OpenJdk"
    apt-get remove --auto-remove -y openjdk*
    apt-get purge --auto-remove -y openjdk*
}

function preConfigurarDependenciasDoJava(){
    # Getting latest LTS version by AdoptOpenJDK API
    echo "Getting latest LTS version by AdoptOpenJDK API"
    LATEST_LTS_JAVA_VERSION=$(curl -fsSl $LATEST_LTS_JAVA_VERSION_URL | python3 -c "import sys, json; print(json.load(sys.stdin)['most_recent_lts'])")
}

function instalarJava(){
    # Updating the apt package index and installing the latest LTS version JDK
    echo "Updating the apt package index and installing the latest LTS version JDK"
    apt-get update
    apt-get install -y openjdk-$LATEST_LTS_JAVA_VERSION-jdk
}

function posConfigurarDependenciasDoJava(){
    # Create Java variables file
    echo "Create Java variables file"
    touch JAVA_VARIABLES_FILE_PATH

    # Insert Java variables inside the file
    echo "Insert Java variables inside the file"
    echo "export JAVA_HOME=/usr/lib/jvm/java-$LATEST_LTS_JAVA_VERSION-openjdk-amd64/" >> JAVA_VARIABLES_FILE_PATH

    # Giving execute permission to the Java variables file
    echo "Giving execute permission to the Java variables file"
    chmod +x JAVA_VARIABLES_FILE_PATH

    # Making variable available in the current shell
    echo "Making variable available in the current shell"
    source JAVA_VARIABLES_FILE_PATH
}

# Execution
# ----------------------------------------------------------------------------------------------------------------

main
