# Arquitectura y flujo de datos

## Recolección

### Node Exporter
Recolecta métricas de:
- CPU
- Memoria RAM
- Disco y filesystem
- Red
- Inodes

---

## Ingesta y agregación

### Prometheus
- Scraping de métricas
- Almacenamiento de series temporales
- Recording rules para KPIs y SLAs

### Alertmanager
- Agrupación de alertas
- Ruteo por severidad y equipo
- Inhibición de alertas redundantes

---

## Visualización

### Grafana
- Dashboards por rol
- Variables dinámicas (env, región, servicio)
- Anotaciones de cambios operativos

Arquitectura del Sistema de Monitoreo de Recursos Cloud

1. Resumen Ejecutivo
El sistema implementa una plataforma de observabilidad distribuida para la infraestructura de la ANSD, permitiendo la supervisión centralizada de recursos en AWS y entornos On-Premise (Proxmox). La solución se basa en un stack de Prometheus, Grafana y Node Exporter, asegurando visibilidad técnica y ejecutiva mediante paneles especializados.
+3
2. Componentes del Stack
Recolección: Node Exporter instalado en cada instancia (VM) para capturar métricas de CPU, RAM, Disco y Red.
+1
Almacenamiento: Prometheus (servidor central) encargado del scraping de métricas y almacenamiento de series temporales.
+2
Visualización: Grafana para la creación de dashboards operativos y una Vista Ejecutiva semaforizada.
+1
Seguridad y Acceso: Cloudflare Zero Trust para la interconexión de entornos mediante túneles seguros, eliminando la necesidad de VPNs tradicionales y apertura de puertos inbound.
+2
3. Modelo de Infraestructura como Código (IaC)
La infraestructura se gestiona de forma modular mediante Terraform, permitiendo un despliegue reproducible y escalable.

Estructura del Proyecto
Plaintext
.
├── infra/
│   ├── environments/
│   │   └── dev/           # Orquestador del entorno de desarrollo
│   ├── modules/
│   │   ├── network/       # VPC, Subredes y Security Groups
│   │   ├── compute/       # Instancias EC2 y Key Pairs
│   │   └── visuals/       # Configuración de monitoreo
│   └── scripts/           # Plantillas (.tftpl) para aprovisionamiento (Nginx, Node Exporter)
├── monitoring/            # Archivos JSON de Dashboards y reglas de Prometheus
└── docs/                  # Documentación técnica y de diseño
4. Flujo de Datos y Conectividad
La arquitectura sigue un modelo de Seguridad Inbound Zero:
+1

Flujo de Métricas: El servidor de Prometheus (On-Premise) solicita métricas a las instancias de AWS a través del Cloudflared Tunnel. La red de Cloudflare actúa como puente virtual entre la VPC privada de AWS y el Data Center local.
+2

Flujo de Visualización: El usuario accede a Grafana vía HTTPS a través de grafana.portalweb.cc. Cloudflare autentica al usuario y redirige el tráfico internamente por el túnel seguro hacia el servidor central.
+1

5. Diseño de Observabilidad
Se implementan vistas diferenciadas por rol:
+1

Vista Técnica: Detalle de recursos por servidor, uso de variables para filtrado y análisis de picos de carga.
Vista Ejecutiva: Enfoque en indicadores de alto nivel como Uptime, disponibilidad de servicios y conteo de alertas activas mediante semáforos visuales.
