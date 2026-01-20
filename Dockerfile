FROM docker.io/n8nio/n8n:latest

USER root

# Investigar qué tipo de sistema es
RUN echo "=== OS Information ===" && \
    cat /etc/os-release 2>/dev/null || echo "No /etc/os-release" && \
    echo "" && \
    echo "=== Available package managers ===" && \
    (command -v apk && echo "apk: FOUND") || echo "apk: NOT FOUND" && \
    (command -v apt-get && echo "apt-get: FOUND") || echo "apt-get: NOT FOUND" && \
    (command -v yum && echo "yum: FOUND") || echo "yum: NOT FOUND" && \
    echo "" && \
    echo "=== Trying to install poppler-utils ===" && \
    (apk add --no-cache poppler-utils && echo "SUCCESS with apk") || \
    (apt-get update && apt-get install -y poppler-utils && echo "SUCCESS with apt-get") || \
    (yum install -y poppler-utils && echo "SUCCESS with yum") || \
    echo "FAILED - No package manager worked"

USER node

EXPOSE 5678
CMD ["n8n"]