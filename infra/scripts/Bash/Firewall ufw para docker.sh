ufw para docker 

#!/bin/bash
set -e

# ==========================================
# CONFIGURACIÓN
# ==========================================
PROMETHEUS_IP="10.10.1.50" # <--- ¡CAMBIA ESTO POR LA IP DE TU SERVIDOR PROMETHEUS!
PORT="9100"

echo "[INFO] Configurando IPTables (Chain DOCKER-USER) para máxima seguridad..."

# ---------------------------------------------------------------------
# EXPLICACIÓN TÉCNICA:
# Docker inserta sus reglas antes que la cadena INPUT normal.
# Para filtrar contenedores de forma efectiva, debemos insertar reglas
# en la cadena especial 'DOCKER-USER', que se evalúa ANTES que las de Docker.
# ---------------------------------------------------------------------

# 1. Limpiar reglas previas en DOCKER-USER relacionadas con este puerto (para evitar duplicados)
# (Este loop borra reglas existentes que coincidan con el puerto 9100 en DOCKER-USER)
iptables -S DOCKER-USER | grep "dport $PORT" | cut -d " " -f 2- | while read -r rule; do
    iptables -D DOCKER-USER $rule
done

# 2. PERMITIR conexión desde Prometheus (Return = Aceptar y salir de la cadena)
# Se inserta en la posición 1 para ser la primera evaluación.
echo "[INFO] Autorizando IP $PROMETHEUS_IP..."
iptables -I DOCKER-USER 1 -p tcp -s "$PROMETHEUS_IP" --dport "$PORT" -j RETURN

# 3. PERMITIR conexión desde Localhost (necesario para pruebas internas en la misma máquina)
iptables -I DOCKER-USER 2 -p tcp -s 127.0.0.1 --dport "$PORT" -j RETURN

# 4. BLOQUEAR todo lo demás para ese puerto
# Se inserta en la posición 3. Todo lo que no sea la IP de arriba, se descarta (DROP).
echo "[INFO] Bloqueando el resto del mundo en el puerto $PORT..."
iptables -I DOCKER-USER 3 -p tcp --dport "$PORT" -j DROP

# 5. También aseguramos la cadena INPUT (para el caso de network_mode: host)
iptables -A INPUT -p tcp -s "$PROMETHEUS_IP" --dport "$PORT" -j ACCEPT
iptables -A INPUT -p tcp --dport "$PORT" -j DROP

# 6. Persistencia (Depende de la distro, ejemplo para debian/ubuntu)
if command -v netfilter-persistent &> /dev/null; then
    netfilter-persistent save
    echo "[INFO] Reglas guardadas persistentemente."
else
    echo "[WARN] Instala 'iptables-persistent' para guardar los cambios tras reiniciar."
fi

echo "--------------------------------------------------------"
echo "[EXITO] Firewall configurado a prueba de Docker."
echo "        Solo $PROMETHEUS_IP puede leer métricas."
echo "--------------------------------------------------------"