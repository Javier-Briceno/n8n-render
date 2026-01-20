# Stage 1: Imagen Alpine completa para obtener poppler-utils
FROM alpine:3.22 AS poppler-stage
RUN apk add --no-cache poppler-utils

# Stage 2: Imagen n8n hardened
FROM docker.io/n8nio/n8n:latest

USER root

# Copiar SOLO los binarios necesarios
COPY --from=poppler-stage /usr/bin/pdftotext /usr/local/bin/pdftotext
COPY --from=poppler-stage /usr/bin/pdfinfo /usr/local/bin/pdfinfo

# Copiar librerías compartidas necesarias
COPY --from=poppler-stage /usr/lib/libpoppler.so* /usr/lib/
COPY --from=poppler-stage /usr/lib/libpoppler-cpp.so* /usr/lib/
COPY --from=poppler-stage /usr/lib/libfreetype.so* /usr/lib/
COPY --from=poppler-stage /usr/lib/libpng16.so* /usr/lib/
COPY --from=poppler-stage /usr/lib/libjpeg.so* /usr/lib/
COPY --from=poppler-stage /usr/lib/libopenjp2.so* /usr/lib/
COPY --from=poppler-stage /usr/lib/liblcms2.so* /usr/lib/
COPY --from=poppler-stage /usr/lib/libtiff.so* /usr/lib/
COPY --from=poppler-stage /usr/lib/libz.so* /usr/lib/
COPY --from=poppler-stage /usr/lib/libbz2.so* /usr/lib/
COPY --from=poppler-stage /usr/lib/libwebp.so* /usr/lib/
COPY --from=poppler-stage /usr/lib/libzstd.so* /usr/lib/
COPY --from=poppler-stage /usr/lib/liblzma.so* /usr/lib/

# Verificar que funciona
RUN pdftotext -v

USER node

EXPOSE 5678
CMD ["n8n"]