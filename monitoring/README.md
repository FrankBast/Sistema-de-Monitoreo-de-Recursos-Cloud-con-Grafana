# Monitoreo y Observabilidad (monitoring/)

Esta carpeta constituye el núcleo del sistema de observabilidad del proyecto. Aquí se define la lógica para la recolección de métricas, la visualización en tableros y la gestión de alertas para la infraestructura híbrida.

## 📂 Estructura del Stack
El despliegue se basa en contenedores distribuidos de la siguiente manera:

* **`prometheus/`**: Servidor central que almacena las métricas de series temporales y ejecuta las reglas de alerta.
* **`grafana/`**: Plataforma de visualización donde se configuran los Data Sources y se importan los dashboards.
* **`alertmanager/`**: Silencia, agrupa y envía notificaciones basadas en las alertas generadas por Prometheus.
* **`blackbox/`**: Exportador utilizado para el sondeo de puntos finales (probes) a través de HTTP, DNS, TCP e ICMP para verificar disponibilidad.
* **`node-exporter/`**: Agente encargado de extraer métricas de hardware y del sistema operativo (CPU, RAM, Disco).

---

## 🚀 Despliegue del Sistema
Para levantar todo el ecosistema de monitoreo, asegúrate de tener instalado **Docker** y **Docker Compose**, luego ejecuta:

```bash
docker-compose up -d
```
## 📊 Configuración de Dashboards
Los tableros de control se encuentran organizados para ofrecer una visión ejecutiva y técnica:

Los archivos de configuración de dashboards se cargan automáticamente si se utiliza la función de provisioning de Grafana.

Se incluyen métricas específicas para el monitoreo de recursos en AWS y servidores on-premise.

## 🛡️ Variables de Entorno
El archivo .env en esta carpeta contiene configuraciones locales para el despliegue (como puertos o versiones de imagen).

Importante: Por motivos de seguridad, este archivo está excluido del repositorio mediante el .gitignore global para proteger la configuración específica del entorno de ejecución.

