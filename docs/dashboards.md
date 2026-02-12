# Documentación de Dashboards de Monitoreo 

## 1. Introducción
Este documento describe los dashboards creados en Grafana, su objetivo,
estructura y las métricas que presentan, así como las mejoras aplicadas
durante el proyecto.

---

## 2. Herramienta utilizada
- Plataforma: Grafana
- Fuente de datos: Prometheus / Node Exporter
- Entorno: AWS

---

## 3. Dashboards implementados

### 3.1 Dashboard – Vista Técnica

**Objetivo:**  
Permitir el análisis detallado de métricas por recurso para operación y soporte técnico.

**Público objetivo:**  
Operadores y equipo técnico.

**Métricas principales:**
- CPU (%)
- Memoria RAM
- Uso de disco
- Estado del servicio

**Estructura:**
- Panel general por recurso
- Paneles individuales por métrica
- Filtros por servidor y servicio

---

### 3.2 Dashboard – Vista Ejecutiva

**Objetivo:**  
Proveer una visión general del estado del sistema para la toma de decisiones.

**Público objetivo:**  
Jefaturas y coordinación.

**Métricas principales:**
- Estado general (verde/amarillo/rojo)
- Disponibilidad (uptime)
- Alertas recientes

**Estructura:**
- Panel resumen
- Indicadores visuales de estado
- Panel de alertas

---

## 4. Buenas prácticas aplicadas
- Uso de colores coherentes para estados.
- Unidades correctas en todas las métricas.
- Nombres claros y descriptivos de paneles.
- Uso de variables para filtrado dinámico.

---

## 5. Cambios y mejoras realizadas
- Ajuste de umbrales de CPU para reducir ruido de alertas.
- Reorganización de paneles para mejorar legibilidad.
- Inclusión de filtros por servidor.

---

## 6. Evidencia visual
Las capturas de los dashboards se encuentran en:
`Screenshots`

- Dashboard vista técnica – estado normal
- Dashboard vista ejecutiva – alerta activa

