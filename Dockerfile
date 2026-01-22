# Use the latest n8n image as the base
FROM docker.io/n8nio/n8n:latest

# Switch to root user to install packages
USER root

# Switch back to the n8n user
USER node