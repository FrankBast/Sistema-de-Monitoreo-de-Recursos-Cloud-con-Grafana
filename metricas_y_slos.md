# Métricas y SLOs

## Métricas mínimas por recurso

### CPU

```promql
100 * (1 - avg(rate(node_cpu_seconds_total{mode="idle"}[5m])) by (instance))
Memoria RAM
promql
Copiar código
100 * (1 - node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)
Disco
promql
Copiar código
100 * (1 - node_filesystem_avail_bytes / node_filesystem_size_bytes)
Red
promql
Copiar código
rate(node_network_receive_bytes_total[5m])
rate(node_network_transmit_bytes_total[5m])
