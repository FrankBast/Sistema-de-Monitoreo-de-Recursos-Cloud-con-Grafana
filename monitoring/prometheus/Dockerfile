ARG VER
FROM prom/prometheus:${VER}

# Cambiamos a root temporalmente para preparar directorios
USER root

# Creamos estructura de directorios antes de copiar archivos (Optimizaci  n de capas)
RUN mkdir -p /etc/prometheus/rules /etc/prometheus/file_sd &&     chown -R nobody:nobody /etc/prometheus /prometheus

# Copiamos configuraciones. Si prometheus.yml cambia, solo se reconstruye esta capa.
COPY prometheus.yml /etc/prometheus/prometheus.yml

# Volvemos al usuario seguro
USER nobody