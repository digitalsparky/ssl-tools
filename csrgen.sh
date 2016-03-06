#!/bin/bash

##
# CSR/Key Generator
# An easy way to create certificate signing requests and private keys
# Author: Matthew Spurrier
# Web: http://www.digitalsparky.com/
##

##
# START CONFIGURATION
##

KEYSTRENGTH=4096

##
# END CONFIGURATION
##


##
# START DEFAULT VARIABLES
##

CSRPATH="./csr"
KEYPATH="./private"
OPENSSL="$(which openssl)"
GENKEY=0
GENCSR=0

##
# END DEFAULT VARIABLES
##

##
# START FUNCTIONS
##

# Help
printHelp() {
    cat <<EOF
Usage:

$0 -n <common-name> <options>
common-name: the FQDN or identifying name for the certificate (ie: your name, or host.example.com)
options:
    -k:     generate an rsa key for the common-name
    -c:     generate a certificate signing request for the common-name (requires key)
    
Example:

$0 -n example.com -k
Generates only the rsa key for the common-name

$0 -n example.com -k -c
Generates the rsa key and certificate signing request based on that key

$0 -n example.com -c
Generates an rsa key based on a pre-existing key only
This requires the key to exist in the private directory, eg:
${KEYPATH}/example.com.key

EOF
    exit 1
}

# Check Options
checkOptions() {
    while getopts ":n:kc" opt; do
        case "${opt}" in
            k)
                GENKEY=1
                ;;
            c)
                GENCSR=1
                ;;
            n)
                CN="${OPTARG}"
                CNKEY="${KEYPATH}/${CN}.key"
                CNCSR="${CSRPATH}/${CN}.csr"
                ;;
            \?)
                echo "Option -${OPTARG} does not exist." >&2
                exit 1
                ;;
            :)
                echo "Options -${OPTARG} requires an argument." >&2
                exit 1
                ;;
        esac
    done
}

# Check Install Environment
checkInstall() {
    if [ ! -x "${OPENSSL}" ]; then
        echo "OpenSSL is not installed, unable to continue"
        exit 1
    fi
    if [ ! -d "${CSRPATH}" ]; then
        mkdir -p "${CSRPATH}"
        if [ "$?" -gt 0 ]; then
            echo "Failed to create CSR Path ${CSRPATH}"
            exit 1
        fi
    fi
    if [ ! -d "${KEYPATH}" ]; then
        mkdir -p "${KEYPATH}"
        if [ "$?" -gt 0 ]; then
            echo "Failed to create Key Path ${KEYPATH}"
            exit 1
        fi
    fi
}

# Generate Key
genKey() {
    checkKeyAbsent
    "${OPENSSL}" genrsa -out "${CNKEY}" "${KEYSTRENGTH}" 
}

# Generate Certificate Signing Request (CSR)
genCSR() {
    checkCSRAbsent
    checkKeyExists
    "${OPENSSL}" req -new -key "${CNKEY}" -out "${CNCSR}"
}

checkKeyAbsent() {
    if [ -f "${CNKEY}" ]; then
        echo "Key file for ${CN} already exists."
        echo "Please remove it or adjust your options."
        echo "File: ${CNKEY}"
        exit 1
    fi
}

checkKeyExists() {
    if [ ! -f "${CNKEY}" ]; then
        echo "Key file for ${CN} does not exist."
        echo "Please copy it to the following location or adjust your options."
        echo "File: ${CNKEY}"
        exit 1
    fi
}

checkCSRExists() {
    if [ ! -f "${CNCSR}" ]; then
        echo "CSR file for ${CN} does not exist."
        echo "Please copy it to the following location or adjust your options."
        echo "File: ${CNKEY}"
        exit 1
    fi
}

checkCSRAbsent() {
    if [ -f "${CNCSR}" ]; then
        echo "CSR file for ${CN} already exists."
        echo "Please remove it or adjust your options"
        echo "File: ${CNCSR}"
        exit 1
    fi
}

##
# END FUNCTIONS
##

##
# START OPERATIONS
##

checkOptions "$@"
checkInstall

if [ -z "${CN}" ]; then
    printHelp
fi
if [ "${GENKEY}" -eq 1 ]; then
    genKey
fi
if [ "${GENCSR}" -eq 1 ]; then
    genCSR
fi
if [ "${GENKEY}" -eq 0 ] && [ "${GENCSR}" -eq 0 ]; then
    printHelp
fi


##
# END OPERATIONS
##

exit 0
