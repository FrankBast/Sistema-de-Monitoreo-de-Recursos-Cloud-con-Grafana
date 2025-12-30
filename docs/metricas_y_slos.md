# Métricas y SLOs

## Métricas mínimas por recurso

### CPU

``promql
100 * (1 - avg(rate(node_cpu_seconds_total{mode="idle"}[5m])) by (instance))

## Memoria RAM
100 * (1 - node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)

## Disco
100 * (1 - node_filesystem_avail_bytes / node_filesystem_size_bytes)

## Red
rate(node_network_receive_bytes_total[5m])
rate(node_network_transmit_bytes_total[5m])

## SLOs simulados (SLO Lite) ##
# Cómputo

CPU promedio < 70% (horario laboral)

RAM < 80% sostenido

FS / Inodes < 85%

## Servicios web

Disponibilidad ≥ 95% mensual

Latencia p95 ≤ 800 ms
