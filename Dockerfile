# Dockerfile to extend the n8n image with additional dependencies
FROM n8nio/n8n:latest

USER root

RUN apk update && \
    apk add --no-cache poppler-utils

USER node
