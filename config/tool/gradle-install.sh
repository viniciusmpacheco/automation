#!/bin/bash

# Creation Date: 28/01/2022
# Author: Lucas Moraes da Silva
# E-mail: lucasmoraessilva01@gmail.com
# Remote Rrepository: https://github.com/viniciusmpacheco/automation/
# Description: Installation and configuration of Gradle on a Linux machine
# Run Information: Preferably, must run on a machine where Gradle is not installed, so there are no installation conflicts. If installed on machines that already have Gradle, the old version will be uninstalled and replaced with the newer one, and all of existents old Gradle files or directories, or what else configuration will be deleted
# Log Directory:
# Use Exemples: 
#       ./automation/config/tool/gradle-install.sh

# Imports
# ----------------------------------------------------------------------------------------------------------------

# Variáveis
# ----------------------------------------------------------------------------------------------------------------

GRADLE_DOWNLOAD_URL="https://services.gradle.org/distributions/gradle-7.3.3-all.zip"
GRADLE_VARIABLES_FILE="/etc/profile.d/gradle.sh"

# Functions
# ----------------------------------------------------------------------------------------------------------------

function main(){
    # Uninstall old versions of Gradle
    echo "Uninstall old versions of Gradle"
    desinstalarVersoesAntigasDoGradle

    # Download Gradle
    echo "Download Gradle"
    baixarGradle

    # Configure Gradle
    echo "Configure Gradle"
    configurarGradle
}

function desinstalarVersoesAntigasDoGradle(){
    # Removing old versions of Gradle
    echo "Removing old versions of Gradle"
    apt-get remove -y gradle
    apt-get purge -y gradle

    # Removing files, directories and settings from old versions of Gradle
    echo "Removing files, directories and settings from old versions of Gradle"
    rm -rf /opt/gradle*/
}

function baixarGradle(){
    # Download the latest Gradle version zipped file to the given path
    echo "Download the latest Gradle version zipped file to the given path"
    wget -O /opt/gradle-7.3.3-all.zip $GRADLE_DOWNLOAD_URL
}

function configurarGradle(){
    # Unzip the file and route its output into the /opt folder
    echo "Unzip the file and route its output into the /opt folder"
    unzip -d /opt/ /opt/gradle-7.3.3-all.zip

    # Configure links to Gradle binary in /opt folder
    echo "Configure links to Gradle binary in /opt folder"
    update-alternatives --install /usr/bin/gradle gradle /opt/gradle-7.3.3/bin/gradle 1001

    # Create Gradle variables file
    echo "Create Gradle variables file"
    touch $GRADLE_VARIABLES_FILE

    # Insert Gradle variables inside the file
    echo "Insert Gradle variables inside the file"
    echo 'export PATH=/opt/gradle-7.3.3/bin:${PATH}' >> $GRADLE_VARIABLES_FILE

    # Giving execute permission to the Gradle variables file
    echo "Giving execute permission to the Gradle variables file"
    chmod +x $GRADLE_VARIABLES_FILE

    # Making variables available in the current shell
    echo "Making variables available in the current shell"
    source $GRADLE_VARIABLES_FILE
}

# Execution
# ----------------------------------------------------------------------------------------------------------------

main
