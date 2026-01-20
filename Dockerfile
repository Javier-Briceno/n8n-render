FROM docker.io/n8nio/n8n:latest

USER root

# Detectar sistema operativo e instalar poppler-utils
RUN if [ -f /etc/alpine-release ]; then \
        echo "Detected Alpine Linux" && \
        apk add --no-cache poppler-utils; \
    elif [ -f /etc/debian_version ]; then \
        echo "Detected Debian/Ubuntu" && \
        apt-get update && \
        apt-get install -y --no-install-recommends poppler-utils && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*; \
    else \
        echo "Unknown OS" && exit 1; \
    fi

USER node

EXPOSE 5678
CMD ["n8n"]