# Dockerfile to extend the n8n image with additional dependencies
FROM n8nio/n8n:latest

USER root

# n8n está basado en Debian → usamos apt
RUN apt-get update && \
    apt-get install -y poppler-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER node
