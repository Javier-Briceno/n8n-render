# Stage 1: Obtener poppler-utils
FROM alpine:3.22 AS poppler-stage
RUN apk add --no-cache poppler-utils fontconfig

# Stage 2: n8n
FROM docker.io/n8nio/n8n:latest

USER root

# Copiar binarios
COPY --from=poppler-stage /usr/bin/pdftotext /usr/local/bin/
COPY --from=poppler-stage /usr/bin/pdfinfo /usr/local/bin/

# Copiar TODAS las librerías (más simple y seguro)
COPY --from=poppler-stage /usr/lib/ /usr/lib/

# Copiar configuración de fontconfig
COPY --from=poppler-stage /etc/fonts/ /etc/fonts/

# Verificar
RUN pdftotext -v

USER node

EXPOSE 5678
CMD ["n8n"]