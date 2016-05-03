#!/bin/bash
CANAME="yourca"

if [ "$(whoami)" != "root" ]; then
    echo "This needs to be root :("
    exit 1
fi

if [ ! -f "/usr/share/ca-certificates/${CANAME}.crt" ]; then
    cp certs/ca.crt /usr/share/ca-certificates/${CANAME}.crt
fi

grep "^${CANAME}.crt" /etc/ca-certificates.conf > /dev/null 2>&1
if [ $? -gt 0 ]; then
    echo "${CANAME}.crt" >> /etc/ca-certificates.conf
fi

update-ca-certificates
