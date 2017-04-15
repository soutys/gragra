#!/usr/bin/env bash

set -ev

cd ./CAs

export PATH=${PATH}:"`dirname ${0}`"

export CA_LEVEL='interm'
export CA_LEVEL_UP='interm'
export CA_POLICY='policy_loose'
export CA_EXT='client_cert'
export KEY_BITS=2048
export CERT_DAYS=90
export KEY_SRC='client'
export CERT_DEST='client'
ca_key_create.sh
ca_${CA_LEVEL}_csr_create.sh
export KEY_SRC='ca_interm'
ca_${CA_LEVEL}_cert_create.sh

chmod 444 ./certs/${CERT_DEST}.cert.pem

openssl verify -CAfile ./certs/ca-chain.cert.pem \
	./certs/${CERT_DEST}.cert.pem

