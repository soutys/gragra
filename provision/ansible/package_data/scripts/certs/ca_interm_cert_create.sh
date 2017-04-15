#!/usr/bin/env bash

set -ev

openssl ca -config ${CA_CONF_PATH}/CAs.conf -extensions ${CA_EXT} \
	-days ${CERT_DAYS} -notext -md sha512 -batch \
	-keyfile ./private/${KEY_SRC}.key.pem \
	-passin file:./private/${KEY_SRC}.key.passwd \
	-in ./csr/${CERT_DEST}.csr.pem \
	-out ./certs/${CERT_DEST}.cert.pem

chmod 444 ./certs/${CERT_DEST}.cert.pem

openssl x509 -noout -text -in ./certs/${CERT_DEST}.cert.pem

