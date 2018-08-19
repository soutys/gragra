Graphite & Grafana
==================

Prepare
-------

.. code:: bash

    virtualenv --python=python2 ./venv
    source ./venv/bin/activate
    pip install -U pip ansible


Common setup
------------

.. code:: bash

    # managing server
    export GRAPHITE_COLLECTOR_HOST=...
    export GRAPHITE_COLLECTOR_PORT=...
    export CERT_CLIENT=...
    export MANAGED_SSH_PORT=...
    ssh-add ~/.ssh/deploy_user_priv_key.pem
    # modify ~/.ssh/config

    # managed server
    adduser deploy_user
    addgroup ssh_users
    adduser deploy_user ssh_users
    # modify sshd config
    # CHECK YOUR SSH ACCESS USING 2ND SHELL BEFORE YOU LOGOUT :)


Development
-----------

.. code:: bash

    # install vagrant, vagrant's plugins etc.

    export ANSIBLE_PROVIDER=virtualbox
    vagrant up --provision --provider ${ANSIBLE_PROVIDER}


Production
----------

.. code:: bash

    ansible-playbook -vv -i ./provision/ansible/managed_hosts ./provision/ansible/managed.yml


Tests / usage
-------------

.. code:: bash

    sudo cp ./ca_root.cert.pem /usr/local/share/ca-certificates/ca_root.cert.pem.crt
    sudo cp ./ca_interm.cert.pem /usr/local/share/ca-certificates/ca_interm.cert.pem.crt
    sudo update-ca-certificates

    curl -v -X POST --cert ./client.cert.pem --key ./client-nopasswd.key.pem --data-binary @metrics.txt \
        https://${GRAPHITE_COLLECTOR_HOST}:${GRAPHITE_COLLECTOR_PORT}/graphite/collector/

