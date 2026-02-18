# Sistema de Monitoreo de Recursos Cloud con Grafana

Este repositorio es un proyecto académico diseñado para la implementación de un sistema de monitoreo integral en entornos de nube híbrida (AWS y On-premise) utilizando el stack de Prometheus y Grafana.

## 📋 Descripción
El sistema permite la recolección, visualización y alertamiento de métricas críticas de infraestructura, asegurando la observabilidad de recursos distribuidos y facilitando la toma de decisiones basada en datos reales de rendimiento.

---

## 📂 Estructura del Proyecto
El repositorio sigue una organización modular para separar la infraestructura de la lógica de monitoreo:

* **`docs/`**: Contiene la documentación técnica, manuales de usuario y diagramas de arquitectura del sistema.
* **`infra/`**: Archivos de Infraestructura como Código (IaC) con Terraform, incluyendo módulos, entornos (dev/prod) y plantillas de configuración (User Data, IAM).
* **`monitoring/`**: Configuración completa del stack de observabilidad (Prometheus, Grafana, Alertmanager y Blackbox) desplegado mediante Docker Compose.
* **`dashboards/`**: Colección de archivos JSON para la importación automática de tableros en Grafana.
* **`tests/`**: Scripts de validación y pruebas de estrés para simular cargas de CPU, RAM y fallos de servicio.
* **`Screenshots/`**: Capturas de pantalla que evidencian el funcionamiento de los tableros y alertas.

---

## 🛠️ Stack Tecnológico
* **Nube**: AWS (EC2, VPC, IAM).
* **IaC**: Terraform.
* **Contenedores**: Docker & Docker Compose.
* **Monitoreo**: Prometheus, Grafana, Node Exporter.

---

## 🚀 Instalación y Despliegue

### 1. Infraestructura (Terraform)
Navega a la carpeta del entorno deseado e inicializa el despliegue:
```bash
cd infra/terraform/aws/environments/dev
terraform init
terraform apply
```
## 2. Stack de Monitoreo (Docker)
Una vez disponible el servidor, levanta los servicios de monitoreo:

```Bash
cd monitoring
docker-compose up -d
```
## 🛡️ Seguridad y Buenas Prácticas
Este repositorio incluye un archivo .gitignore configurado para proteger información sensible:

* **Se excluyen archivos de estado de Terraform (.tfstate).

* **Se bloquean llaves privadas (.pem, .key) y variables de entorno (.env, .tfvars).

* **La carpeta local secret/ está completamente excluida del control de versiones.

## 🧪 Pruebas de Estrés
Para validar las alertas, ejecuta los scripts disponibles en tests/:

* **`cpu_stress.sh`**: Genera carga artificial en el procesador.

* **`ram_stress.py`**: Consume memoria RAM para verificar umbrales de alerta.

* **`stop_agent.sh`**: Simula la caída de un servicio de monitoreo.

### Desarrollado como parte del proyecto de la Estancia Profesional ###
