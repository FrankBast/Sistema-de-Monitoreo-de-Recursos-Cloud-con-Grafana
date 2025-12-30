# Métricas y SLOs

## Métricas mínimas por recurso

### CPU

```promql
100 * (1 - avg(rate(node_cpu_seconds_total{mode="idle"}[5m])) by (instance))
Memoria RAM
