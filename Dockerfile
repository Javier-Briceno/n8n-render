// Dockerfile to extend the n8n image with additional dependencies
FROM n8nio/n8n:latest // Use the latest n8n image as the base

USER root // Switch to root user to install packages

RUN apt-get update && \
    apt-get install -y poppler-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER node // Switch back to the n8n user
