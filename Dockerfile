FROM postgres:17.5

# Copy the pg_hba.conf override script
COPY ssl-config.sh /docker-entrypoint-initdb.d/ssl-config.sh

# Set file permissions
RUN chmod +x /docker-entrypoint-initdb.d/ssl-config.sh 
