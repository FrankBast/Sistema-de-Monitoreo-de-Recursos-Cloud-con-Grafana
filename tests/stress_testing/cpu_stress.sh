#!/bin/bash
# Descripción: Genera carga del 100% en 2 núcleos durante 60 segundos.

echo "🔥 Iniciando prueba de estrés de CPU..."
echo "Simulando carga en 2 núcleos. Duración: 60 segundos."

# El comando 'yes' es ligero pero consume un ciclo completo de CPU.
# 'timeout' asegura que el proceso muera automáticamente después de 60s.
for i in 1 2; do
    timeout 60s bash -c "yes > /dev/null" &
done

echo "✅ Carga iniciada. Revisa tu Dashboard en Grafana."
echo "Los procesos terminarán automáticamente en 1 minuto."
wait
