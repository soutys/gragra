#!/usr/bin/env bash

set -ev

openssl req -utf8 -nameopt multiline,utf8 -config ${CA_CONF_PATH}/CAs.conf \
	-key ./private/${KEY_SRC}.key.pem \
	-passin file:./private/${KEY_SRC}.key.passwd \
	-new -x509 -days 7300 -sha512 -extensions ${CA_EXT} \
	-out ./certs/${CERT_DEST}.cert.pem

chmod 444 ./certs/${CERT_DEST}.cert.pem

openssl x509 -noout -text -in ./certs/${CERT_DEST}.cert.pem

