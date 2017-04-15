#!/usr/bin/env bash

set -ev

openssl req -utf8 -nameopt multiline,utf8 -config ${CA_CONF_PATH}/CAs.conf \
	-key ./private/${KEY_SRC}.key.pem \
	-passin file:./private/${KEY_SRC}.key.passwd \
	-new -sha512 \
	-out ./csr/${CERT_DEST}.csr.pem

openssl req -noout -text -in ./csr/${CERT_DEST}.csr.pem

