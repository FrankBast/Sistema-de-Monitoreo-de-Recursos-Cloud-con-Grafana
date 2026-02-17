# ==============================================================================
# MÓDULO DE CÓMPUTO (ANSD)
# Propósito: Definir instancias EC2, Key Pairs y la inyección de User Data
# ==============================================================================

# 1. GESTIÓN DE LLAVES SSH (Acceso Administrativo)
# ------------------------------------------------------------------------------
# Sube tu llave pública (.pub) a AWS para inyectarla en las VMs al nacer.
resource "aws_key_pair" "ansd_auth" {
  key_name   = "${var.project_name}-key"
  public_key = file(var.public_key_path)

  tags = {
    Name = "${var.project_name}-key"
  }
}

# 2. INSTANCIAS EC2 (Nodos del Proyecto)
# ------------------------------------------------------------------------------
resource "aws_instance" "ansd_nodes" {
  # Iteramos sobre la matriz definida en terraform.tfvars (portal, api, db, tunnel)
  for_each = var.node_matrix

  # --- Configuración de Hardware ---
  ami           = var.ami_id
  instance_type = "t2.micro" # Capa gratuita (Suficiente para esta simulación)
  key_name      = aws_key_pair.ansd_auth.key_name

  # --- Networking y Seguridad ---
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_groups
  
  # IP Privada Estática: Vital para que el DNS interno (/etc/hosts) coincida siempre
  private_ip             = each.value.ip

  # --- Identidad y Permisos (IAM) ---
  # Permite usar SSM (Consola Web) y CloudWatch (Logs)
  iam_instance_profile = var.iam_instance_profile

  # --- Almacenamiento (Root Volume) ---
  root_block_device {
    volume_size = 10    # GB
    volume_type = "gp3" # SSD de propósito general (más rápido/barato que gp2)
    encrypted   = true  # Seguridad básica
    
    tags = {
      Name = "${var.project_name}-${each.key}-root"
    }
  }

  # ============================================================================
  # USER DATA: INYECCIÓN DE SCRIPTS DE INICIO
  # Aquí combinamos los 3 scripts que creamos en una sola secuencia de ejecución.
  # ============================================================================
  user_data = join("\n", [
    
    # -----------------------------------------------------------
    # CAPA 1: BOOTSTRAP COMÚN (Se ejecuta en TODOS los nodos)
    # Instala Docker, Netplan, /etc/hosts y herramientas base.
    # -----------------------------------------------------------
    templatefile("${var.scripts_path}/common_bootstrap.sh.tftpl", {
      custom_user = var.ansd_custom_user
      node_matrix = var.node_matrix
      dns_servers = var.dns_servers
    }),

    # -----------------------------------------------------------
    # CAPA 2: GATEWAY SETUP (Solo para el nodo 'tunnel')
    # Instala cloudflared y conecta la red a Internet vía Zero Trust.
    # -----------------------------------------------------------
    each.key == "tunnel" ? 
      templatefile("${var.scripts_path}/gateway_setup.sh.tftpl", {
        tunnel_token = var.cloudflare_tunnel_token
        warp_token   = var.warp_registration_token
        custom_user  = var.ansd_custom_user
      }) : "",

    # -----------------------------------------------------------
    # CAPA 3: APP SETUP (Solo para 'portal', 'api', 'db')
    # Despliega los contenedores específicos del rol (Nginx, Postgres, etc.)
    # -----------------------------------------------------------
    each.key != "tunnel" ? 
      templatefile("${var.scripts_path}/app_setup.sh.tftpl", {
        role        = each.value.role
        node_name   = each.key
        custom_user = var.ansd_custom_user
      }) : ""
  ])

  # Aseguramos que User Data se vuelva a ejecutar si cambiamos la instancia
  user_data_replace_on_change = true

  # --- Etiquetado ---
  tags = {
    Name        = "${var.project_name}-${each.key}" # Ej: ansd-simulation-portal
    Role        = each.value.role
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}