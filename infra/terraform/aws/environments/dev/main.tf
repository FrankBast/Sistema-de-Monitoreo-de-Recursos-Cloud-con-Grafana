# ==============================================================================
# ORQUESTADOR PRINCIPAL (Entorno DEV)
# Propósito: Llamar a los módulos y pasarles las variables
# ==============================================================================

# 1. MÓDULO DE IDENTIDAD (IAM)
module "iam" {
  source       = "../../modules/iam"
  project_name = var.project_name
}

# 2. MÓDULO DE RED (VPC, Subnets, Firewalls)
module "network" {
  source       = "../../modules/network"
  project_name = var.project_name
  aws_region   = var.aws_region
  vpc_cidr     = var.vpc_cidr
  subnet_cidr  = var.subnet_cidr
  admin_ip     = var.admin_ip
}

# 3. MÓDULO DE CÓMPUTO (EC2 Instances + Scripts)
module "compute" {
  source           = "../../modules/compute"
  project_name     = var.project_name
  ami_id           = var.ami_id
  
  vpc_id           = module.network.vpc_id
  # Conexión con Red e IAM
  subnet_id            = module.network.public_subnet_id
  security_groups      = [
    module.network.internal_sg_id, 
    module.network.admin_sg_id
  ]
  iam_instance_profile = module.iam.instance_profile_name
  
  # Datos de configuración
  public_key_path      = var.public_key_path
  scripts_path         = var.scripts_path
  templates_path   = var.scripts_path
  node_matrix          = var.node_matrix
  
  # Secretos y Variables para Scripts
  ansd_custom_user        = var.ansd_custom_user
  cloudflare_tunnel_token = var.cloudflare_tunnel_token
  warp_registration_token = var.warp_registration_token
  dns_servers             = var.dns_servers
}

# 4. MÓDULO VISUALS (Observabilidad AWS)
module "visuals" {
  source           = "../../modules/visuals"
  project_name     = var.project_name
  # Pasamos el mapa de IDs que sale del módulo compute
  instance_details = module.compute.node_details
}