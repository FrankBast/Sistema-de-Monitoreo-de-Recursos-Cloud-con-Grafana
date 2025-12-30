# Diseño lógico del sistema de monitoreo

## Contexto general

Este documento describe el diseño lógico de una solución de observabilidad
para la supervisión de infraestructura cloud de una entidad gubernamental
ficticia denominada **ANSD**.

La solución está basada en **Node Exporter, Prometheus, Alertmanager y Grafana**
y tiene como objetivo detectar riesgos operativos relacionados con capacidad,
disponibilidad, rendimiento y red.

---

## Objetivo del monitoreo

- Centralizar métricas críticas de infraestructura y servicios
- Detectar anomalías de forma temprana
- Simular SLOs y SLAs básicos (“SLO Lite”)
- Proveer visibilidad diferenciada por rol:
  - Ejecutivo
  - Operaciones
  - SOC / DevOps

---

## Recursos monitoreados

- Máquinas virtuales / hosts
- Servicios web y APIs
- Bases de datos (a nivel host)
- Infraestructura de red

---

## Flujo lógico de alto nivel

1. Los exporters recolectan métricas
2. Prometheus ingesta y procesa la información
3. Alertmanager gestiona notificaciones
4. Grafana presenta la información al usuario final
