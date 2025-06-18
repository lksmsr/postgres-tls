# Start from postgres 17.5 as a base image
FROM postgres:17.5

# Copy the entrypoint script to the image
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh"]
