ufw para nativo

#!/bin/bash
set -e

# ==========================================
# CONFIGURACIÓN
# ==========================================
PROMETHEUS_IP="10.10.1.50" # <--- ¡CAMBIA ESTO POR LA IP DE TU SERVIDOR PROMETHEUS!
PORT="9100"

echo "[INFO] Configurando UFW para restringir Node Exporter..."

# 1. Habilitar UFW si no está activo (CUIDADO: Asegura tener acceso SSH permitido)
# Si estás conectado por SSH, asegúrate de permitirlo antes de activar
ufw allow ssh
ufw allow 22/tcp

# 2. Resetear regla previa para el puerto 9100 (limpieza)
ufw delete allow $PORT/tcp 2> /dev/null || true

# 3. APLICAR REGLA DE LISTA BLANCA (Whitelist)
# "Permitir entrada al puerto 9100 SOLO desde la IP de Prometheus"
ufw allow from "$PROMETHEUS_IP" to any port "$PORT" proto tcp comment 'Solo Prometheus Server'

# 4. Denegar explícitamente cualquier otro tráfico a ese puerto (redundancia de seguridad)
# Nota: UFW bloquea por defecto lo que no está permitido, pero esto es para auditoría visual.
# No es estrictamente necesario si la política por defecto es DENY, pero es buena práctica documental.

# 5. Recargar reglas
ufw reload

echo "--------------------------------------------------------"
echo "[EXITO] Reglas de UFW aplicadas."
echo "        Puerto $PORT accesible SOLAMENTE desde: $PROMETHEUS_IP"
echo "--------------------------------------------------------"
ufw status numbered | grep $PORT