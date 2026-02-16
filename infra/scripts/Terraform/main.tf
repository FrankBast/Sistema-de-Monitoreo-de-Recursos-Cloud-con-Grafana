El cambio clave: El recurso local_file ahora escribe directamente en la carpeta de monitoreo.

# ... (Bloques de Provider, VPC, Subnets y Security Groups igual que antes) ...

# ==========================================
# VARIABLES LOCALES Y SECRETOS
# ==========================================
variable "aws_gateway_token_path" {
  default = "../secrets/cf_token_aws.txt"
}

locals {
  # Leemos el token de AWS desde el archivo seguro
  gateway_token = trimspace(file(var.aws_gateway_token_path))
  
  # Script base de instalación para las VMs
  install_docker = <<-EOF
    #!/bin/bash
    set -e
    hostnamectl set-hostname %s
    apt-get update && apt-get install -y docker.io docker-compose-plugin
    systemctl start docker
    mkdir -p /opt/app
    cat <<EOT > /opt/app/docker-compose.yml
    %s
    EOT
    cd /opt/app && docker compose up -d
  EOF
}

# ==========================================
# INSTANCIAS (VMs)
# ==========================================

# 1. GATEWAY (Usa el token leído del archivo)
resource "aws_instance" "gateway" {
  # ... (configuracion ami, instance_type, etc) ...
  tags = { Name = "gateway" }
  
  user_data = format(local.install_docker, "gateway", 
    templatefile("${path.module}/templates/gateway.yaml", {
      TOKEN = local.gateway_token
    })
  )
}

# 2. DATABASE, WEBSERVER, CONTAINERS (Configuración estándar)
resource "aws_instance" "database" {
  # ... (configuracion ami, sg, etc) ...
  tags = { Name = "database" }
  user_data = format(local.install_docker, "database", file("${path.module}/templates/database.yaml"))
}
# ... (Repetir para webserver y containers) ...


# ==========================================
# INTEGRACIÓN: GENERAR ARCHIVO PARA PROMETHEUS
# ==========================================
# Terraform escribe las IPs DIRECTAMENTE en la carpeta de monitoreo
resource "local_file" "prometheus_targets" {
  filename = "../monitoring/config/targets.json" # <--- RUTA RELATIVA CLAVE
  
  content  = jsonencode([
    {
      targets = [
        "${aws_instance.database.private_ip}:9100",
        "${aws_instance.webserver.private_ip}:9100",
        "${aws_instance.gateway.private_ip}:9100"
        # Agrega las instancias que necesites
      ]
      labels = {
        env    = "aws-prod"
        region = "us-east-1"
        source = "terraform-auto"
      }
    }
  ])
  
  # Permisos seguros (lectura para todos, escritura solo dueño)
  file_permission = "0644"
}

# ==========================================
# OUTPUTS (INFORMACIÓN FINAL)
# ==========================================

output "gateway_public_ip" {
  description = "IP Publica del Gateway (Para referencia)"
  value       = aws_instance.gateway_vm.public_ip
}

output "gateway_private_ip" {
  description = "IP Privada del Gateway (Para ruteo interno)"
  value       = aws_instance.gateway_vm.private_ip
}

# Si tienes otras VMs definidas en este mismo archivo, agrégalas así:
# output "db_private_ip" {
#   value = aws_instance.base_datos.private_ip
# }
