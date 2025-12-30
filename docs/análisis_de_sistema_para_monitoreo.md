## Introducción

Este documento presenta el análisis inicial para el diseño de un sistema de
monitoreo y observabilidad en la nube, orientado a la detección temprana de
riesgos operativos y al apoyo en la toma de decisiones técnicas y ejecutivas.

# Análisis del sistema de monitoreo

## Recursos a monitorear

Los recursos que la entidad gubernamental ficticia **ANSD** requiere monitorear
se dividen en las siguientes categorías:

### Infraestructura en la nube

- Máquinas virtuales (VMs)
- Contenedores
- Bases de datos administradas
- Almacenamiento de objetos (buckets)

Estos recursos constituyen la base de los servicios críticos que deben ser
supervisados para garantizar la continuidad operativa.

---

### Métricas operativas

Las métricas operativas permiten evaluar el rendimiento y la estabilidad de la
infraestructura y los servicios. Entre las principales métricas se incluyen:

- Uso de CPU en servidores y contenedores
- Consumo de memoria RAM
- Espacio disponible en disco
- Métricas de red:
  - Latencia
  - Ancho de banda
  - Errores de transmisión

---

### Disponibilidad (Uptime)

Se monitorea el estado de los servicios críticos para determinar si se
encuentran operativos o no. Esta métrica es fundamental para:

- Detectar caídas de servicio
- Medir el cumplimiento de acuerdos de nivel de servicio (SLA)
- Identificar patrones de indisponibilidad

---

## Alcance del proyecto

Para la ejecución de pruebas de funcionamiento del sistema de monitoreo, se
considera el siguiente entorno controlado:

- 1 máquina virtual destinada a base de datos
- 1 máquina virtual para contenedores
- 1 máquina virtual para el servicio web
- 1 bucket para almacenamiento de objetos

En total, el proyecto contempla **tres máquinas virtuales independientes** y
un bucket de almacenamiento, sobre los cuales se instalarán agentes de
monitoreo para la recolección de métricas.

Adicionalmente, se utilizarán **scripts de automatización** que permitirán:

- Simplificar la instalación de agentes
- Repetir despliegues bajo demanda
- Reducir errores manuales

---

## Indicadores clave de desempeño (KPIs)

Los KPIs definidos se enfocan en medir la **confiabilidad**, el **rendimiento**
y la **gestión operativa** de los servicios monitoreados.

### Rendimiento

- Identificación de tiempos de respuesta elevados
- Detección de saturación de CPU y memoria RAM
- Análisis de latencia y congestión de red

---

### Disponibilidad

- Métricas consolidadas de disponibilidad de servicios
- Evaluación del cumplimiento de SLA definidos
- Seguimiento de caídas y recuperaciones de servicio

---

### Gestión de incidentes

- **MTTR (Mean Time To Recovery):** tiempo promedio para recuperar un servicio
- **MTBF (Mean Time Between Failures):** tiempo promedio entre fallas

Estos indicadores permiten evaluar la efectividad de los procesos de respuesta
ante incidentes.

---

### Capacidad y costos

- Consumo del presupuesto de nube por dependencia o servicio
- Identificación de recursos sobredimensionados o subutilizados
- Optimización de costos mediante análisis de uso histórico
  
Este análisis sirve como insumo para el documento de diseño lógico de
monitoreo, donde se definen las métricas, SLOs y dashboards asociados.

## Conclusión del análisis

El análisis realizado permite identificar los recursos críticos, definir el
alcance del proyecto y establecer los indicadores clave necesarios para el
diseño de una solución de monitoreo efectiva, escalable y alineada a los
objetivos operativos de la ANSD.
