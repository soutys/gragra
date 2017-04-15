#!/usr/bin/env bash

set -ev

cd ./CAs

export PATH=${PATH}:"`dirname ${0}`"

export CA_LEVEL='root'
export CA_LEVEL_UP='root'
export CA_POLICY='policy_strict'
export CA_EXT='v3_ca'
export CA_CN="${CA_CN_ROOT}"
export KEY_BITS=4096
export CERT_DAYS=7300
export KEY_SRC="ca_${CA_LEVEL}"
export CERT_DEST="ca_${CA_LEVEL}"
ca_key_create.sh
ca_${CA_LEVEL}_cert_create.sh

export CA_LEVEL='interm'
export CA_LEVEL_UP='interm'
export CA_POLICY='policy_loose'
export CA_EXT='v3_intermediate_ca'
export CA_CN="${CA_CN_INTERM}"
export KEY_BITS=4096
export CERT_DAYS=3650
export KEY_SRC="ca_${CA_LEVEL}"
export CERT_DEST="ca_${CA_LEVEL}"
ca_key_create.sh
ca_${CA_LEVEL}_csr_create.sh

export CA_LEVEL='interm'
export CA_LEVEL_UP='root'
export CA_POLICY='policy_strict'
export CA_EXT='v3_intermediate_ca'
export CA_CN="${CA_CN_INTERM}"
export KEY_BITS=4096
export CERT_DAYS=3650
export KEY_SRC="ca_${CA_LEVEL_UP}"
export CERT_DEST="ca_${CA_LEVEL}"
ca_${CA_LEVEL}_cert_create.sh

cat \
	./certs/ca_${CA_LEVEL}.cert.pem \
	./certs/ca_${CA_LEVEL_UP}.cert.pem \
	> ./certs/ca-chain.cert.pem
chmod 444 ./certs/ca-chain.cert.pem

