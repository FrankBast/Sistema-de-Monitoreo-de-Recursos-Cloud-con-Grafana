# Guía de Uso de los Dashboards de Monitoreo

## 1. Introducción
Este documento describe el uso e interpretación de los dashboards de
monitoreo del sistema, los cuales están organizados en dos vistas:
técnica y ejecutiva, según el tipo de usuario.

---

## 2. Vista Técnica de Monitoreo

### 2.1 Público objetivo
- Operadores
- Equipo técnico

### 2.2 Objetivo
Permitir el análisis detallado del comportamiento de los recursos
monitoreados y la detección temprana de incidentes técnicos.

### 2.3 Cómo leer los gráficos
- **CPU (%)**: porcentaje de uso del procesador.
- **Memoria RAM**: consumo de memoria del sistema.
- **Disco (GB / %)**: espacio disponible y utilizado.
- **Estado del servicio**: disponibilidad del servicio monitoreado.

### 2.4 Significado de colores y estados
- 🟢 Verde: funcionamiento normal.
- 🟡 Amarillo: valores cercanos al umbral definido.
- 🔴 Rojo: valores críticos o fallo detectado.

### 2.5 Qué hacer ante métricas críticas
- **CPU alta**: revisar procesos activos y carga del sistema.
- **Disco bajo**: validar espacio disponible y liberar recursos.
- **Servicio caído**: verificar conectividad y estado del servicio.

### 2.6 Evidencia visual
- Figura 1: Vista técnica – estado normal.
- Figura 2: Vista técnica – CPU en estado crítico.

---

## 3. Vista Ejecutiva de Monitoreo

### 3.1 Público objetivo
- Jefaturas
- Coordinación del proyecto

### 3.2 Objetivo
Brindar una visión general del estado del sistema para apoyar la toma de
decisiones sin necesidad de análisis técnico detallado.

### 3.3 Cómo interpretar la vista ejecutiva
- **Estado general del sistema**: semáforo verde/amarillo/rojo.
- **Disponibilidad (%)**: nivel de uptime del servicio.
- **Alertas recientes**: incidentes detectados en el periodo.

### 3.4 Significado de colores
- 🟢 Verde: operación normal.
- 🟡 Amarillo: advertencia o riesgo potencial.
- 🔴 Rojo: incidente activo que requiere atención.

### 3.5 Acciones recomendadas
- Estado verde: continuar monitoreo.
- Estado amarillo: solicitar revisión técnica.
- Estado rojo: escalar incidente al equipo técnico.

### 3.6 Evidencia visual
- Figura 3: Vista ejecutiva – estado general.
- Figura 4: Vista ejecutiva – alerta activa.

---

## 4. Consideraciones finales
Ambas vistas se complementan: la vista ejecutiva permite una rápida
evaluación del estado del sistema, mientras que la vista técnica facilita
el análisis detallado y la resolución de incidentes.
