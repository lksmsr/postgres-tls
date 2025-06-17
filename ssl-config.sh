#!/bin/bash

# Add certificate files
echo "$SERVER_CRT" > /var/lib/postgresql/server.crt
echo "$SERVER_KEY" > /var/lib/postgresql/server.key
echo "$ROOT_CA_CRT" > /var/lib/postgresql/rootCA.crt

# Set permissions for the certificate files
chmod 600 /var/lib/postgresql/server.* /var/lib/postgresql/rootCA.crt
chown postgres:postgres /var/lib/postgresql/server.* /var/lib/postgresql/rootCA.crt


# Configure PostgreSQL to use SSL
echo "ssl = on" >> /var/lib/postgresql/data/postgresql.conf
echo "ssl_cert_file = '/var/lib/postgresql/server.crt'" >> /var/lib/postgresql/data/postgresql.conf
echo "ssl_key_file = '/var/lib/postgresql/server.key'" >> /var/lib/postgresql/data/postgresql.conf
echo "ssl_ca_file = '/var/lib/postgresql/rootCA.crt'" >> /var/lib/postgresql/data/postgresql.conf

# Force SSL
echo "hostssl all all all cert clientcert=verify-full" > /var/lib/postgresql/data/pg_hba.conf
