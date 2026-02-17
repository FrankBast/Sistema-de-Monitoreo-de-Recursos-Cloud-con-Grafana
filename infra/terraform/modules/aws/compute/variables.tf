# ==============================================================================
# VARIABLES DEL MÓDULO COMPUTE (ANSD)
# Propósito: Definir los inputs requeridos para crear las instancias EC2
# ==============================================================================

# --- IDENTIFICADORES GENERALES ---

variable "project_name" {
  description = "Nombre del proyecto para etiquetado (Tags)"
  type        = string
}

variable "ami_id" {
  description = "ID de la Amazon Machine Image (AMI) a usar (ej: Ubuntu 22.04)"
  type        = string
}

# --- RED Y SEGURIDAD ---

variable "vpc_id" {
  description = "ID de la VPC donde se desplegarán los nodos"
  type        = string
}

variable "subnet_id" {
  description = "ID de la Subnet (Pública o Privada) donde vivirán las instancias"
  type        = string
}

variable "security_groups" {
  description = "Lista de IDs de Security Groups a aplicar a las instancias"
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "Nombre del perfil IAM para dar permisos a la instancia (SSM, S3, etc.)"
  type        = string
  default     = null # Opcional, por si algún entorno no lo requiere
}

variable "public_key_path" {
  description = "Ruta local al archivo de llave pública (.pub) para SSH"
  type        = string
}

# --- CONFIGURACIÓN DE INSTANCIAS (Matriz) ---

variable "node_matrix" {
  description = "Mapa de objetos que define cada nodo (nombre, IP, rol)"
  type = map(object({
    ip   = string
    role = string
  }))
}

# --- VARIABLES PARA TEMPLATES Y SCRIPTS ---

variable "scripts_path" {
  description = "Ruta absoluta o relativa a la carpeta de scripts (.sh.tftpl)"
  type        = string
}

variable "templates_path" {
  description = "Ruta absoluta o relativa a la carpeta de templates (Dockerfiles)"
  type        = string
}

variable "ansd_custom_user" {
  description = "Usuario del sistema operativo a crear (ej: ansd-admin)"
  type        = string
}

variable "dns_servers" {
  description = "Lista de servidores DNS a inyectar en Netplan (ej: ['1.1.1.1'])"
  type        = list(string)
  default     = ["1.1.1.1", "8.8.8.8"]
}

# --- SECRETOS (Cloudflare) ---

variable "cloudflare_tunnel_token" {
  description = "Token de autenticación para cloudflared (Tunnel)"
  type        = string
  sensitive   = true # Oculta el valor en los logs de Terraform
}

variable "warp_registration_token" {
  description = "Token para registrar el cliente WARP en la red Zero Trust"
  type        = string
  sensitive   = true
}