#!/bin/bash

echo "START CONFIG SCRIPT"

echo "$SERVER_CRT" > /var/lib/postgresql/server.crt
echo "$SERVER_KEY" > /var/lib/postgresql/server.key
echo "$ROOT_CA_CRT" > /var/lib/postgresql/rootCA.crt


echo $SERVER_CRT $SERVER_KEY $ROOT_CA_CRT


chmod 600 /var/lib/postgresql/server.* /var/lib/postgresql/rootCA.crt
chown postgres:postgres /var/lib/postgresql/server.* /var/lib/postgresql/rootCA.crt

echo "hostssl all all all cert clientcert=verify-full" > /var/lib/postgresql/data/pg_hba.conf
