#!/usr/bin/env bash

set -ev

openssl genrsa -aes256 -out ./private/${KEY_SRC}.key.pem -passout file:./private/${KEY_SRC}.key.passwd 4096

chmod 400 ./private/${KEY_SRC}.key.*

openssl rsa -noout -text -in ./private/${KEY_SRC}.key.pem -passin file:./private/${KEY_SRC}.key.passwd

