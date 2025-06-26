FROM infiniflow/ragflow:v0.19.1-slim

ARG RAGFLOW_HOST

ARG MYSQL_DBNAME
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_HOST

ARG MINIO_USER
ARG MINIO_PASSWORD
ARG MINIO_HOST
ARG MINIO_PORT

ARG ES_HOST
ARG ES_USER
ARG ELASTIC_PASSWORD

ARG OS_HOST
ARG OS_USER
ARG OPENSEARCH_PASSWORD

ARG INFINITY_HOST

ARG REDIS_PASSWORD
ARG REDIS_HOST
ARG REDIS_PORT

# Basic authentication arguments (optional)
ARG USE_BASICAUTH=false
ARG NGINX_BASICAUTH_USER
ARG NGINX_BASICAUTH_PASSWORD

# Convert build args to env vars for runtime
ENV NGINX_BASICAUTH_ENABLED=${USE_BASICAUTH}
ENV NGINX_BASICAUTH_USER=${NGINX_BASICAUTH_USER}
ENV NGINX_BASICAUTH_PASSWORD=${NGINX_BASICAUTH_PASSWORD}

COPY ./entrypoint.sh /ragflow/entrypoint.sh
COPY ./service_conf.yaml.template /ragflow/conf/service_conf.yaml.template

# Copy nginx-basicauth files to a temporary location
COPY ./nginx-basicauth /ragflow/nginx-basicauth

# Copy default nginx config
COPY ./nginx/ragflow.conf /etc/nginx/conf.d/ragflow.conf
COPY ./nginx/proxy.conf /etc/nginx/proxy.conf
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# Copy basic auth nginx config if USE_BASICAUTH is true
RUN if [ "$USE_BASICAUTH" = "true" ]; then \
        cp -f /ragflow/nginx-basicauth/ragflow.conf /etc/nginx/conf.d/ragflow.conf; \
    fi

# Copy basic auth setup script
RUN chmod +x /ragflow/nginx-basicauth/setup-auth.sh && \
    cp /ragflow/nginx-basicauth/setup-auth.sh /ragflow/setup-auth.sh

RUN chmod +x /ragflow/entrypoint.sh

ENTRYPOINT ["/ragflow/entrypoint.sh"]