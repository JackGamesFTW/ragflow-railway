#!/bin/bash
# Script to set up nginx basic authentication from environment variables

# Check if basic auth is enabled
if [ "${NGINX_BASICAUTH_ENABLED}" != "true" ]; then
    echo "Basic authentication is disabled (NGINX_BASICAUTH_ENABLED != true)"
    # Remove auth directives from nginx config if disabled
    sed -i '/auth_basic/d' /etc/nginx/conf.d/ragflow.conf
    exit 0
fi

# Check if username and password are provided
if [ -z "${NGINX_BASICAUTH_USER}" ] || [ -z "${NGINX_BASICAUTH_PASSWORD}" ]; then
    echo "ERROR: NGINX_BASICAUTH_USER and NGINX_BASICAUTH_PASSWORD must be set when basic auth is enabled"
    exit 1
fi

# Install htpasswd if not available
if ! command -v htpasswd &> /dev/null; then
    echo "Installing apache2-utils for htpasswd..."
    apt-get update && apt-get install -y apache2-utils
fi

# Create .htpasswd file
echo "Creating .htpasswd file for user: ${NGINX_BASICAUTH_USER}"
htpasswd -bc /etc/nginx/.htpasswd "${NGINX_BASICAUTH_USER}" "${NGINX_BASICAUTH_PASSWORD}"

# Set proper permissions
chmod 644 /etc/nginx/.htpasswd

echo "Basic authentication configured successfully" 