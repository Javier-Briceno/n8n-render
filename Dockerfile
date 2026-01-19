# Dockerfile to extend the n8n image with additional dependencies
# --- Stage 1: build tools ---
FROM alpine:3.19 AS tools

RUN apk add --no-cache poppler-utils

# --- Stage 2: n8n ---
FROM n8nio/n8n:latest

USER root

# copiar solo el binario necesario
COPY --from=tools /usr/bin/pdftotext /usr/bin/pdftotext

# copiar librerías necesarias
COPY --from=tools /usr/lib/libpoppler*.so* /usr/lib/
COPY --from=tools /usr/lib/libcairo*.so* /usr/lib/
COPY --from=tools /usr/lib/libfontconfig*.so* /usr/lib/
COPY --from=tools /usr/lib/libfreetype*.so* /usr/lib/
COPY --from=tools /usr/lib/libpng*.so* /usr/lib/

USER node
