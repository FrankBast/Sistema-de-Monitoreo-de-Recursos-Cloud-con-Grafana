# Prometheus – Métricas y reglas

## Recording rules

Las reglas de grabación permiten calcular KPIs reutilizables como:

- Uso de CPU
- Uso de RAM
- Uso de filesystem
- Errores de red
- SLA mensual de servicios web

Las reglas completas se encuentran en:
`/monitoring/prometheus/rules/`

Ejemplo:

```yaml
record: node:cpu_usage:percent
expr: 100 * (1 - avg(rate(node_cpu_seconds_total{mode="idle"}[5m])) by (instance))
