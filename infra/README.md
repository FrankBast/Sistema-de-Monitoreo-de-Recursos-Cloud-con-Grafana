# Infraestructura y Aprovisionamiento (infra/)

Esta carpeta contiene todos los recursos necesarios para definir, desplegar y configurar la infraestructura base del sistema de monitoreo utilizando un enfoque de **Infraestructura como Código (IaC)**.

## 📂 Estructura de la Carpeta

La carpeta se organiza por el tipo de recurso y herramienta utilizada:

* **`terraform/`**: Contiene la lógica principal de la infraestructura distribuida en:
    * **`aws/environments/`**: Configuraciones específicas para entornos como `dev` o `prod`.
    * **`modules/`**: Componentes de infraestructura reutilizables (VPC, EC2, IAM).
* **`templates/`**: Archivos de configuración dinámica y plantillas de inicialización:
    * `user_data.tpl`: Script de automatización para la configuración inicial de servidores.
    * `iam_policy.json`: Definición de permisos y roles de seguridad.
    * `docker-compose.tftpl`: Plantilla para el despliegue dinámico del stack de monitoreo.
* **`scripts/`**: Scripts de automatización en Bash o Python para tareas de post-despliegue o configuración local.

---

## 🛠️ Tecnologías Utilizadas
* **Terraform**: Para el orquestamiento de recursos en la nube.
* **AWS CLI**: Interfaz de línea de comandos para la gestión de servicios de Amazon.

---

## 🚀 Guía de Uso Rápido

### 1. Requisitos
Asegúrate de tener configuradas tus credenciales de AWS localmente (fuera de este repositorio) y Terraform instalado.

### 2. Despliegue de un Entorno
Para levantar los recursos en el entorno de desarrollo:

```bash
cd terraform/aws/environments/dev
terraform init
terraform plan
terraform apply
```
## 3. Personalización de Plantillas
Si necesitas modificar el comportamiento inicial del servidor (instalar nuevos paquetes o agentes), edita el archivo templates/user_data.tpl antes de ejecutar el comando apply de Terraform.

## 🛡️ Seguridad
Los archivos de estado de Terraform (.tfstate) y las variables sensibles (.tfvars) están excluidos por el .gitignore de la raíz para prevenir la exposición de datos críticos.

Las llaves de acceso SSH (.pem) nunca deben guardarse en esta carpeta.
