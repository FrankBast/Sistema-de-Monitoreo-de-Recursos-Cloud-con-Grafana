#!/bin/bash
# Descripción: Inicia el servicio de monitoreo para simular recuperación.

SERVICE_NAME="node_exporter"

echo "♻️  Iniciando el servicio $SERVICE_NAME..."
sudo systemctl start $SERVICE_NAME

# Verificamos que arrancó bien
if systemctl is-active --quiet $SERVICE_NAME; then
    echo "✅ Servicio $SERVICE_NAME está corriendo nuevamente."
    echo "La alerta en Grafana debería resolverse pronto."
else
    echo "❌ El servicio no pudo arrancar. Revisa los logs: journalctl -u $SERVICE_NAME"
fi
