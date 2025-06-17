FROM postgres:17.5

# Copy the init script
COPY ssl-config.sh /docker-entrypoint-initdb.d/ssl-config.sh
