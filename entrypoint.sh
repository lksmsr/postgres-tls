#!/bin/bash
set -e

# Add certificate files
echo "$SERVER_CRT" > /var/lib/postgresql/server.crt
echo "$SERVER_KEY" > /var/lib/postgresql/server.key
echo "$ROOT_CA_CRT" > /var/lib/postgresql/rootCA.crt

# Update file permissions of certificates
chmod 600 /var/lib/postgresql/server.* /var/lib/postgresql/rootCA.crt
chown postgres:postgres /var/lib/postgresql/server.* /var/lib/postgresql/rootCA.crt

# Only write to the data dir if it is not empty
if [ "$(ls -A /var/lib/postgresql/data)" ]; then
  # Configure PostgreSQL to use SSL
  echo "ssl = on" >> /var/lib/postgresql/data/postgresql.conf
  echo "ssl_cert_file = '/var/lib/postgresql/server.crt'" >> /var/lib/postgresql/data/postgresql.conf
  echo "ssl_key_file = '/var/lib/postgresql/server.key'" >> /var/lib/postgresql/data/postgresql.conf
  echo "ssl_ca_file = '/var/lib/postgresql/rootCA.crt'" >> /var/lib/postgresql/data/postgresql.conf

  # Enforce SSL for all connections
  echo "hostssl all all all cert clientcert=verify-full" > /var/lib/postgresql/data/pg_hba.conf
fi


# Enforce SSL for all connections
echo "hostssl all all all cert clientcert=verify-full" > /var/lib/postgresql/data/pg_hba.conf

# Run the base entrypoint
docker-entrypoint.sh postgres
