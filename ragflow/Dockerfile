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

COPY ./entrypoint.sh /ragflow/entrypoint.sh
COPY ./service_conf.yaml.template /ragflow/conf/service_conf.yaml.template
COPY ./nginx/ragflow.conf /etc/nginx/conf.d/ragflow.conf
COPY ./nginx/proxy.conf /etc/nginx/proxy.conf
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

RUN chmod +x /ragflow/entrypoint.sh

ENTRYPOINT ["/ragflow/entrypoint.sh"]
