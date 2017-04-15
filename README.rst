export ANSIBLE_PROVIDER=virtualbox
#export ANSIBLE_PROVIDER=managed

export GRAPHITE_COLLECTOR_HOST=...
export GRAPHITE_COLLECTOR_PORT=...
export CERT_CLIENT=...
export MANAGED_SSH_PORT=...

vagrant up --provision --provider ${ANSIBLE_PROVIDER}

sudo cp ./ca_root.cert.pem /usr/local/share/ca-certificates/ca_root.cert.pem.crt
sudo cp ./ca_interm.cert.pem /usr/local/share/ca-certificates/ca_interm.cert.pem.crt
sudo update-ca-certificates

curl -v -X POST --cert ./client.cert.pem --key ./client-nopasswd.key.pem --data-binary @metrics.txt \
    https://${GRAPHITE_COLLECTOR_HOST}:${GRAPHITE_COLLECTOR_PORT}/graphite/collector/


ansible-playbook -vv -i ./provision/ansible/managed_hosts ./provision/ansible/managed.yml

