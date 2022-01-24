#!/bin/bash

# Creation Date: 19/01/2022
# Author: Vinicius de Moraes Pacheco
# E-mail: vinicius.mpacheco@hotmail.com
# Remote Rrepository: https://github.com/viniciusmpacheco/automation/
# Description: Facilitate the creation of standardized log messages and their records in certain directories.
# Log Directory: /var/log/default-logger/defaultLogFile.txt
# Use Exemples: 
#       source ./automation/helpers/log/logger.sh 
#           log FORMAT=oneline LEVEL=info MESSAGE="Não foi possível completar sua ligação" DIRECTORY="/var/log/my-log" FILE="log.txt"
#           registrarLogEmArquivo FORMAT=oneline LEVEL=info MESSAGE="Não foi possível completar sua ligação" DIRECTORY="/var/log/my-log" FILE="log.txt"

# Imports
# ----------------------------------------------------------------------------------------------------------------

# Variáveis
# ----------------------------------------------------------------------------------------------------------------

DEFAULT_LOG_FILE="defaultLogFile.txt"
DEFAULT_LOG_DIRECTORY="/var/log/logger-default/"
DEFAULT_LOG_DATETIME=$(date +"%a %x %X (GMT %:z)")
LOG_LEVEL="INFO"
LOG_MESSAGE=""
LOG_FORMAT=""
LOG_DIRECTORY=""
LOG_FILE=""

# Functions
# ----------------------------------------------------------------------------------------------------------------

function log()){
    atribuirValorDasVariaveisDeLog "$@"
    criarMensagemDeLog
}

function registrarLogEmArquivo(){
    atribuirValorDasVariaveisDeLog "$@"
    if [ "$LOG_DIRECTORY" == "" -a "$LOG_FILE" != "" ]; then
        touch $DEFAULT_LOG_DIRECTORY/$DEFAULT_LOG_FILE
        criarMensagemDeLog >> $DEFAULT_LOG_DIRECTORY/$DEFAULT_LOG_FILE
    else
        touch $LOG_DIRECTORY/$LOG_FILE
        criarMensagemDeLog >> $LOG_DIRECTORY/$LOG_FILE
    fi
}

function atribuirValorDasVariaveisDeLog(){
    for parameter in "$@"
    do
        # Set LOG_LEVEL variable
        if [[ $(echo $parameter | grep LEVEL=) != "" ]]
        then
            LOG_LEVEL=$(echo $parameter | tr -d 'LEVEL=' | tr '[:lower:]' '[:upper:]')
        # Set LOG_MESSAGE variable
        elif [[ $(echo $parameter | grep FORMAT=) != "" ]]
        then
            LOG_FORMAT=$(echo $parameter | tr -d 'FORMAT=')
        # Set LOG_FORMAT variable
        elif [[ $(echo $parameter | grep MESSAGE=) != "" ]]
        then
            LOG_MESSAGE=$(echo $parameter | tr -d 'MESSAGE=')
        # Set LOG_DIRECTORY variable
        elif [[ $(echo $parameter | grep DIRECTORY=) != "" ]]
        then
            LOG_DIRECTORY=$(echo $parameter | tr -d 'DIRECTORY=')
        # Set LOG_FILE variable
        elif [[ $(echo $parameter | grep FILE=) != "" ]]
        then
            LOG_FILE=$(echo $parameter | tr -d 'FILE=')
        fi
    done
}

function criarMensagemDeLog(){
    case $LOG_FORMAT in
        oneline)
            echo "ONELINE"
            criarMensagemDeLogLinhaUnica
        ;;
        multiline)
            criarMensagemDeLogMultiline
        ;;
        json)
            criarMensagemDeLogJSON
        ;;
    esac
}

function criarMensagemDeLogLinhaUnica(){
    # One line log message
    echo "$DEFAULT_LOG_DATETIME $USER [$LOG_LEVEL]: $LOG_MESSAGE"
}

function criarMensagemDeLogMultiline(){
    # Multiline log message
    echo "----------------------------------------------------------------"
    echo "Datetime: $DEFAULT_LOG_DATETIME"			
    echo "Level: $LOG_LEVEL"	
    echo "User: $USER"					
    echo "Message: $LOG_MESSAGE"
    echo "----------------------------------------------------------------"
}

function criarMensagemDeLogJSON(){
    # Log message in JSON format
    echo "{\"log\":[{\"datetime\":\"$DEFAULT_LOG_DATETIME\",\"level\":\"$LOG_LEVEL\",\"user\":\"$USER\",\"message\":\"$LOG_MESSAGE\"}]}"
}

# Execution
# ----------------------------------------------------------------------------------------------------------------