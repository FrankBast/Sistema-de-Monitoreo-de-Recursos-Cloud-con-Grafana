# Pruebas y Validaciones (tests/)

Esta carpeta contiene scripts diseñados para validar el funcionamiento del sistema de monitoreo y asegurar que las reglas de alerta configuradas en Grafana y Prometheus respondan correctamente ante incidentes reales.

## 📂 Contenido de la Carpeta

La carpeta se organiza principalmente en pruebas de estrés y simulaciones de fallo de servicio:

* **`stress_testing/`**: Scripts para forzar el consumo de recursos de hardware.
    * `cpu_stress.sh`: Genera una carga de trabajo del 100% en los núcleos del procesador durante un tiempo determinado.
    * `ram_stress.py`: Asigna una cantidad específica de memoria RAM para activar umbrales de alerta de "Memoria Crítica".
* **`availability/`**: Scripts para probar la detección de caídas de servicio.
    * `stop_agent.sh`: Detiene el servicio `node_exporter` para simular la pérdida de conectividad con un nodo.
    * `start_agent.sh`: Reactiva el servicio para verificar la resolución automática de la alerta en Grafana.

---

## 🛠️ Instrucciones de Uso

### 1. Preparación de Permisos
Antes de ejecutar los scripts de Bash, asegúrate de otorgarles permisos de ejecución:
```bash
chmod +x tests/stress_testing/*.sh
```
### 2. Ejecución de Pruebas de CPU
Para simular un uso alto de CPU y observar la subida en tus dashboards:
```bash
./tests/stress_testing/cpu_stress.sh
```
## 3. Ejecución de Pruebas de RAM
Requiere Python 3 instalado en el nodo:
 * `tests/stress_testing/ram_stress.py`

## ⚠️ Advertencia de Seguridad
Estos scripts están diseñados para consumir recursos del sistema de forma intencional.

No los ejecutes en entornos de producción sin supervisión.

Los scripts de estrés incluyen un temporizador de seguridad para detenerse automáticamente después de 60 segundos y evitar el bloqueo total del sistema.

## 📊 Validación de Alertas
El flujo esperado tras ejecutar estos scripts es:

Disparo: La métrica cruza el umbral definido en Grafana.

Notificación: El estado de la alerta cambia a "Firing".

Resolución: Tras finalizar el script o reiniciar el servicio, el estado vuelve a "OK".
