# Dockerfile to extend the n8n image with additional dependencies
FROM n8nio/n8n:latest

USER root

# n8n está basado en Alpine Linux, por lo que usamos apk para instalar poppler-utils
RUN apk add --no-cache poppler-utils

USER node
