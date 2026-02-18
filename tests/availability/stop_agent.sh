#!/bin/bash
# Descripción: Detiene el servicio de monitoreo para simular una caída.

SERVICE_NAME="node_exporter" # Cambia esto si usas otro agente (ej. telegraf)

echo "🛑 Deteniendo el servicio $SERVICE_NAME..."
sudo systemctl stop $SERVICE_NAME

if [ $? -eq 0 ]; then
    echo "✅ Servicio detenido exitosamente."
    echo "⚠️  Tu Dashboard debería mostrar 'No Data' o estado 'Down' en unos momentos."
else
    echo "❌ Error al detener el servicio. ¿Tienes permisos de sudo?"
fi
