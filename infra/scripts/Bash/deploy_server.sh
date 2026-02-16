#!/bin/bash
set -e

# ==========================================
# 1. VARIABLES Y CONFIGURACIÓN
# ==========================================
BASE_DIR="/opt/ansd-monitoring"
PROM_DATA_DIR="$BASE_DIR/prometheus_data"
GRAF_DATA_DIR="$BASE_DIR/grafana_data"
CONFIG_DIR="$BASE_DIR/config"

# Versiones estables y fijas para evitar roturas en actualizaciones automáticas (Eficiencia)
PROM_VERSION="v2.45.0"   # LTS Version
GRAF_VERSION="10.1.0"

echo "[INFO] Iniciando despliegue automatizado del Stack de Observabilidad..."

# =================================================
# 2. PREPARACIÓN DE SEGURIDAD (Sistema de Archivos)
# =================================================
echo "[INFO] Creando estructura de directorios..."
mkdir -p "$PROM_DATA_DIR" "$GRAF_DATA_DIR" "$CONFIG_DIR"

echo "[INFO] Aplicando permisos de seguridad (Least Privilege)..."
# Prometheus corre como usuario 'nobody' (UID 65534) por defecto en imágenes oficiales
# Grafana suele correr como UID 472.
# Asignamos propiedad solo a los volúmenes de datos, no a la configuración.
sudo chown -R 65534:65534 "$PROM_DATA_DIR"
sudo chown -R 472:472 "$GRAF_DATA_DIR"
# Los directorios de configuración deben ser root:root y solo lectura para otros
sudo chown -R root:root "$CONFIG_DIR"
sudo chmod 755 "$CONFIG_DIR"

# ==========================================
# 3. GENERACIÓN DE CONFIGURACIÓN (prometheus.yml)
# ==========================================
echo "[INFO] Generando configuración base de Prometheus..."
cat <<EOF > "$CONFIG_DIR/prometheus.yml"
global:
  scrape_interval: 15s     # Frecuencia estándar para no saturar la red [cite: 51]
  evaluation_interval: 15s

# Reglas de alertas (se configurarán en una etapa posterior del proyecto)
  rule_files:
# 
 - "alert.rules"

scrape_configs:
  # 1. Monitoreo del propio servidor central
  - job_name: 'prometheus_server'
    static_configs:
      - targets: ['localhost:9090']

  # 2. Job de Auto-Descubrimiento Infraestructura ANSD
  - job_name: 'aws-infrastructure'
    file_sd_configs:
      - files:
        - '/etc/prometheus/targets.json'	# Lee el archivo generado
    # Opcional: Si usas Cloudflared como proxy SOCKS5 para llegar a las IPs
    # proxy_url: 'http://cloudflared:port'

EOF

# ==========================================
# 4. GENERACIÓN DE DOCKER COMPOSE (Hardened)
# ==========================================
echo "[INFO] Generando docker-compose.yml seguro..."
cat <<EOF > "$BASE_DIR/docker-compose.yml"
version: '3.8'

services:
  prometheus:
    image: prom/prometheus:$PROM_VERSION
    container_name: prometheus_server
    restart: unless-stopped
    # --- SEGURIDAD ---
    user: "65534:65534"  # Ejecutar estrictamente como 'nobody'
    read_only: true      # Sistema de archivos inmutable
    cap_drop:
      - ALL              # Sin privilegios de root/kernel
    security_opt:
      - no-new-privileges:true
    
    # --- EFICIENCIA ---
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--storage.tsdb.retention.time=30d'  # Retención de 30 días para controlar disco
      - '--storage.tsdb.retention.size=50GB' # Límite duro de espacio en disco
      - '--web.console.libraries=/usr/share/prometheus/console_libraries'
      - '--web.console.templates=/usr/share/prometheus/consoles'
    
    volumes:
      - $CONFIG_DIR/prometheus.yml:/etc/prometheus/prometheus.yml:ro # Solo lectura
      - $PROM_DATA_DIR:/prometheus
    
    ports:
      - "9090:9090"
    networks:
      - monitoring

  grafana:
    image: grafana/grafana:$GRAF_VERSION
    container_name: grafana_server
    restart: unless-stopped
    # --- SEGURIDAD ---
    user: "472:472"
    cap_drop:
      - ALL
    security_opt:
      - no-new-privileges:true
    
    depends_on:
      - prometheus
    
    volumes:
      - $GRAF_DATA_DIR:/var/lib/grafana
    
    ports:
      - "3000:3000"
    networks:
      - monitoring

networks:
  monitoring:
    driver: bridge
EOF

# ==========================================
# 5. DESPLIEGUE
# ==========================================
cd "$BASE_DIR"
echo "[INFO] Levantando servicios..."
# Verificamos si docker compose (plugin) o docker-compose (standalone) existe
if docker compose version > /dev/null 2>&1; then
    docker compose up -d
else
    docker-compose up -d
fi

echo "----------------------------------------------------------"
echo " [EXITO] Servidor de Monitoreo ANSD desplegado."
echo "         Prometheus: http://IP-SERVIDOR:9090"
echo "         Grafana:    http://IP-SERVIDOR:3000 (Admin/admin)"
echo ""
echo "         Directorio base: $BASE_DIR"
echo "         Configuración:   $CONFIG_DIR/prometheus.yml"
echo "----------------------------------------------------------"
