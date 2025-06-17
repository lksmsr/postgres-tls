#!/bin/bash
# Override pg_hba.conf to enforce TLS
set -e
echo "hostssl all all all cert clientcert=verify-full" > /var/lib/postgresql/data/pg_hba.conf
