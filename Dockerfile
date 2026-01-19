# Dockerfile to extend the n8n image with additional dependencies
FROM n8nio/n8n:latest

USER root

RUN apt-get update && \
    apt-get install -y poppler-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER node
