FROM postgres:17.5

# Copy the pg_hba.conf override script
COPY ssh-config.sh /docker-entrypoint-initdb.d/ssh-config.sh

# Set file permissions
RUN chmod +x /docker-entrypoint-initdb.d/ssh-config.sh && \
    chmod 600 /var/lib/postgresql/server.* /var/lib/postgresql/rootCA.crt && \
    chown postgres:postgres /var/lib/postgresql/server.* /var/lib/postgresql/rootCA.crt

# Set SSL config
RUN echo "ssl = on" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "ssl_cert_file = '/var/lib/postgresql/server.crt'" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "ssl_key_file = '/var/lib/postgresql/server.key'" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "ssl_ca_file = '/var/lib/postgresql/rootCA.crt'" >> /usr/share/postgresql/postgresql.conf.sample
