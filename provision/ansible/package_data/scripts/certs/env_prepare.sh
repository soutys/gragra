#!/usr/bin/env bash

set -ev

mkdir -p ./CAs
cd ./CAs

mkdir -p ./{certs,crl,csr,newcerts,private}
chmod 700 ./private
for level in root interm ; do
	openssl rand -base64 30 > ./private/ca_${level}.key.passwd
	chmod 400 ./private/ca_${level}.key.passwd
	touch ./${level}_index.txt
	echo 1000 > ./${level}_serial
	echo 1000 > ./${level}_crlnumber
done

for dest in server client ; do
	openssl rand -base64 30 > ./private/${dest}.key.passwd
	chmod 400 ./private/${dest}.key.passwd
done

touch ../.env_ready
