# ==============================================================================
# VARIABLES GLOBALES DEL PROYECTO (ANSD)
# Propósito: Definir los tipos y descripciones de todos los inputs necesarios
# ==============================================================================

# --- 1. CONFIGURACIÓN GENERAL ---

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre base para etiquetar recursos (ej: ansd-simulation)"
  type        = string
  default     = "ansd-simulation"
}

# --- 2. RED Y SEGURIDAD ---

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC (Red Privada Virtual)"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Bloque CIDR para la Subred Pública"
  type        = string
  default     = "10.0.1.0/24"
}

variable "admin_ip" {
  description = "Tu dirección IP pública (/32) para permitir SSH y acceso administrativo"
  type        = string
  # No ponemos default por seguridad; debe venir de terraform.tfvars o setup.sh
}

variable "dns_servers" {
  description = "Servidores DNS que usarán las instancias (Cloudflare/Google)"
  type        = list(string)
  default     = ["1.1.1.1", "8.8.8.8"]
}

# --- 3. CÓMPUTO E INSTANCIAS ---

variable "ami_id" {
  description = "ID de la Amazon Machine Image (Ubuntu 22.04 LTS en us-east-1)"
  type        = string
  default     = "ami-0c7217cdde317cfec" # Canonical Ubuntu 22.04 LTS (Verificar región)
}

variable "public_key_path" {
  description = "Ruta local al archivo de llave pública SSH"
  type        = string
  default     = "../../../secret/ansd_key.pub" # Ruta relativa desde environments/dev
}

variable "scripts_path" {
  description = "Ruta local donde se encuentran los scripts .sh.tftpl"
  type        = string
  default     = "../../../../scripts" # Ruta relativa desde environments/dev
}

# --- 4. MATRIZ DE NODOS (La joya de la corona) ---
# Define la estructura exacta de tus 4 máquinas: IP, Rol y Nombre.

variable "node_matrix" {
  description = "Mapa de nodos a desplegar con sus IPs y Roles específicos"
  type = map(object({
    ip   = string
    role = string
  }))
  default = {
    portal = { ip = "10.0.1.10", role = "frontend" }
    api    = { ip = "10.0.1.20", role = "backend" }
    db     = { ip = "10.0.1.30", role = "database" }
    tunnel = { ip = "10.0.1.40", role = "gateway" }
  }
}

# --- 5. CREDENCIALES Y SECRETOS (Sensibles) ---

variable "ansd_custom_user" {
  description = "Nombre del usuario administrativo del sistema operativo (Linux)"
  type        = string
  default     = "ansd-admin"
}

variable "cloudflare_tunnel_token" {
  description = "Token de autenticación para el servicio cloudflared"
  type        = string
  sensitive   = true # Oculta el valor en los logs de Terraform plan
}

variable "warp_registration_token" {
  description = "Token de registro para el cliente WARP (Zero Trust)"
  type        = string
  sensitive   = true
}