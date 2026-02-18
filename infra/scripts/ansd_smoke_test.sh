#!/bin/bash
# ==============================================================================
# ANSD INFRASTRUCTURE SMOKE TEST (On-Premise -> AWS Tunnel)
# Propósito: Validar conectividad E2E, resolución DNS y servicios de aplicación.
# ==============================================================================

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}>>> INICIANDO PRUEBA DE HUMO (SMOKE TEST) ANSD <<<${NC}"
echo "Desde: $(hostname) ($(hostname -I | awk '{print $1}'))"
echo "Hacia: Infraestructura AWS (Vía Cloudflare Tunnel)"
echo "---------------------------------------------------"

# 1. VERIFICACIÓN DE CONECTIVIDAD BÁSICA (PING)
# ------------------------------------------------------------------------------
check_ping() {
    target=$1
    name=$2
    echo -n "Probando conectividad a $name ($target)... "
    if ping -c 1 -W 2 $target > /dev/null 2>&1; then
        echo -e "${GREEN}[OK]${NC}"
    else
        echo -e "${RED}[FAIL] - El host no responde o el Túnel está caído.${NC}"
        return 1
    fi
}

# 2. VERIFICACIÓN DE SERVICIOS HTTP (CURL)
# ------------------------------------------------------------------------------
check_http() {
    url=$1
    expected=$2
    echo -n "Probando servicio HTTP en $url... "
    response=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 3 $url)
    
    if [ "$response" == "200" ]; then
        echo -e "${GREEN}[OK] (HTTP 200)${NC}"
    else
        echo -e "${RED}[FAIL] (HTTP $response) - El contenedor web no responde.${NC}"
    fi
}

# 3. VERIFICACIÓN DE PUERTOS TCP (NETCAT)
# ------------------------------------------------------------------------------
check_port() {
    host=$1
    port=$2
    service=$3
    echo -n "Probando puerto $port ($service) en $host... "
    if nc -z -w 2 $host $port; then
        echo -e "${GREEN}[ABIERTO]${NC}"
    else
        echo -e "${RED}[CERRADO/TIMEOUT] - Revisa Security Groups o Docker.${NC}"
    fi
}

# --- EJECUCIÓN DE PRUEBAS ---

# A) El Gateway (Debe responder siempre)
check_ping "10.0.1.40" "Gateway (Tunnel)"

# B) Portal Web (Debe tener Nginx en puerto 80)
check_ping "10.0.1.10" "Portal"
check_http "http://10.0.1.10" "Nginx Welcome"

# C) API Backend (Debe responder JSON en puerto 80)
check_ping "10.0.1.20" "API"
check_http "http://10.0.1.20" "Whoami JSON"

# D) Base de Datos (Debe tener puerto 5432 abierto)
check_ping "10.0.1.30" "Database"
check_port "10.0.1.30" "5432" "PostgreSQL"

# E) Observabilidad (Todos deben exponer métricas en 9100)
echo "---------------------------------------------------"
echo "Verificando Observabilidad (Node Exporter):"
for ip in 10.0.1.10 10.0.1.20 10.0.1.30 10.0.1.40; do
    check_http "http://$ip:9100/metrics" "Prometheus Metrics"
done

echo "---------------------------------------------------"
echo -e "${YELLOW}>>> PRUEBA FINALIZADA <<<${NC}"