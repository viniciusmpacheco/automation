#!/bin/bash

# Creation Date: 27/01/2022
# Author: Lucas Moraes da Silva
# E-mail: lucasmoraessilva01@gmail.com
# Remote Rrepository: https://github.com/viniciusmpacheco/automation/
# Description: Installs the latest version of Maven.
# Run Information: Preferably, it should be run on a machine that does not have any version of Maven installed. If the machine has any version installed, remove it and install the latest version.
# Log Directory:
# Use Exemples: 
#       ./automation/config/tool/node-install.sh

# Imports
# ----------------------------------------------------------------------------------------------------------------

# Variáveis
# ----------------------------------------------------------------------------------------------------------------

MAVEN_LATEST_VERSION_URL="https://dlcdn.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz"
MAVEN_COMPRESSED_FILE_PATH="/opt/apache-maven-3.8.4-bin.tar.gz"
MAVEN_VARIABLES_FILE_PATH="/etc/profile.d/maven.sh"

# Functions
# ----------------------------------------------------------------------------------------------------------------

function main(){
    # Remove old versions of maven
    echo "Remove old versions of maven"
    removerVersoesAntigasDoMaven

    # Download Maven
    echo "Download Maven"
    baixarMaven

    # Configure Maven
    echo "Configure Maven"
    configurarMaven
}

function removerVersoesAntigasDoMaven(){
    # Remove installed version of Maven
    echo "Remove installed version of Maven"
    apt-get remove -y maven
    apt-get purge -y maven

    # Remove link to Maven binary
    echo "Remove link to Maven binary"
    update-alternatives --remove maven /opt/apache-maven*/bin/mvn
}

function baixarMaven(){
    # Download the latest Maven version zipped file to the given path
    echo "Download the latest Maven version zipped file to the given path"
    curl -fsSlo $MAVEN_COMPRESSED_FILE_PATH $MAVEN_LATEST_VERSION_URL
}

function configurarMaven(){
    # Unzip the file and route its output into the /opt folder
    echo "Unzip the file and route its output into the /opt folder"
    tar xzvf $MAVEN_COMPRESSED_FILE_PATH -C /opt/

    # Configure links to downloaded Maven binary in /opt folder
    echo "Configure links to downloaded Maven binary in /opt folder"
    update-alternatives --install /usr/bin/mvn maven /opt/apache-maven-3.8.4/bin/mvn 1001

    # Create Maven variables file
    echo "Create Maven variables file"
    touch $MAVEN_VARIABLES_FILE_PATH

    # Insert Maven variables inside the file
    echo "Insert Maven variables inside the file"
    echo "export M2_HOME=/opt/apache-maven-3.8.4" >> $MAVEN_VARIABLES_FILE_PATH
    echo "export MAVEN_HOME=/opt/apache-maven-3.8.4" >> $MAVEN_VARIABLES_FILE_PATH
    echo 'export PATH=${M2_HOME}/bin:${PATH}' >> $MAVEN_VARIABLES_FILE_PATH

    # Giving execute permission to the Maven variables file
    echo "Giving execute permission to the Maven variables file"
    chmod +x $MAVEN_VARIABLES_FILE_PATH

    # Making variables available in the current shell
    echo "Making variables available in the current shell"
    source $MAVEN_VARIABLES_FILE_PATH
}

# Execution
# ----------------------------------------------------------------------------------------------------------------

main
