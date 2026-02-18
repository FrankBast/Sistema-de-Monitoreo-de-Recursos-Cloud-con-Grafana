#!/bin/bash
# ==============================================================================
# ANSD LOCAL ENVIRONMENT SETUP
# Propósito: Preparar la máquina de gestión para desplegar con Terraform
# Ejecución: sudo ./scripts/setup.sh
# ==============================================================================

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Directorios Clave (Rutas relativas desde la ubicación del script)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$SCRIPT_DIR/.."
SECRET_DIR="$PROJECT_ROOT/secret"
TF_DEV_DIR="$PROJECT_ROOT/terraform/aws/environments/dev"

echo -e "${YELLOW}>>> INICIANDO CONFIGURACIÓN DEL ENTORNO DE GESTIÓN ANSD <<<${NC}"

# 1. VERIFICACIÓN E INSTALACIÓN DE DEPENDENCIAS
# ------------------------------------------------------------------------------
echo -e "\n[1/4] Verificando dependencias..."

# Función para instalar Terraform (Ubuntu/Debian)
install_terraform() {
    echo " -> Terraform no encontrado. Instalando..."
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
    wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt-get update && sudo apt-get install -y terraform
}

# Verificar Terraform
if ! command -v terraform &> /dev/null; then
    install_terraform
else
    echo -e "${GREEN} -> Terraform ya está instalado.$(NC)"
fi

# Verificar AWS CLI
if ! command -v aws &> /dev/null; then
    echo -e "${YELLOW} -> AWS CLI no encontrado. Se recomienda instalarlo: 'sudo apt install awscli'${NC}"
fi

# 2. GESTIÓN DE SECRETOS Y LLAVES SSH
# ------------------------------------------------------------------------------
echo -e "\n[2/4] Configurando seguridad y llaves..."
mkdir -p "$SECRET_DIR"

KEY_NAME="ansd_key"
PRIVATE_KEY="$SECRET_DIR/$KEY_NAME.pem"
PUBLIC_KEY="$SECRET_DIR/$KEY_NAME.pub"

if [ -f "$PRIVATE_KEY" ]; then
    echo -e "${GREEN} -> Las llaves SSH ya existen en $SECRET_DIR${NC}"
else
    echo " -> Generando nuevo par de llaves SSH ($KEY_NAME)..."
    ssh-keygen -t rsa -b 4096 -f "$SECRET_DIR/$KEY_NAME" -N "" -q
    mv "$SECRET_DIR/$KEY_NAME" "$PRIVATE_KEY"
    mv "$SECRET_DIR/$KEY_NAME.pub" "$PUBLIC_KEY"
    
    # Permisos restrictivos (Vital para que SSH no rechace la llave)
    chmod 400 "$PRIVATE_KEY"
    chmod 644 "$PUBLIC_KEY"
    echo -e "${GREEN} -> Llaves generadas correctamente.${NC}"
fi

# 3. PREPARACIÓN DE TERRAFORM VARIABLES
# ------------------------------------------------------------------------------
echo -e "\n[3/4] Verificando configuración de variables..."

TFVARS_FILE="$TF_DEV_DIR/terraform.tfvars"

if [ -f "$TFVARS_FILE" ]; then
    echo -e "${GREEN} -> terraform.tfvars ya existe.${NC}"
else
    echo -e "${YELLOW} -> terraform.tfvars no encontrado. Creando plantilla de ejemplo...${NC}"
    cat <<EOF > "$TFVARS_FILE"
# --- PLANTILLA GENERADA POR SETUP.SH ---
aws_region   = "us-east-1"
project_name = "ansd-simulation"
admin_ip     = "$(curl -s ifconfig.me)/32" # Tu IP actual detectada
node_matrix = {
  portal = { ip = "10.0.1.10", role = "frontend" }
  api    = { ip = "10.0.1.20", role = "backend" }
  db     = { ip = "10.0.1.30", role = "database" }
  tunnel = { ip = "10.0.1.40", role = "gateway" }
}
# SECRETOS (Rellenar manualmente)
cloudflare_tunnel_token = "REEMPLAZAR_CON_TOKEN_TUNNEL"
warp_registration_token = "REEMPLAZAR_CON_TOKEN_WARP"
ansd_custom_user        = "ansd-admin"
EOF
    echo -e "${RED} [!] AVISO: Se ha creado $TFVARS_FILE. Debes editarlo con tus tokens reales antes de desplegar.${NC}"
fi

# 4. INICIALIZACIÓN DE TERRAFORM
# ------------------------------------------------------------------------------
echo -e "\n[4/4] Inicializando Terraform en entorno DEV..."

cd "$TF_DEV_DIR"

# Formatear el código para asegurar que sea legible
terraform fmt -recursive ../../../

# Iniciar backend y descargar providers
if terraform init; then
    echo -e "\n${GREEN}>>> SETUP COMPLETADO EXITOSAMENTE <<<${NC}"
    echo "Pasos siguientes:"
    echo "1. Edita: nano $TFVARS_FILE (Pon tus tokens de Cloudflare)"
    echo "2. Revisa: cd $TF_DEV_DIR && terraform plan"
    echo "3. Despliega: terraform apply"
else
    echo -e "\n${RED}>>> ERROR AL INICIALIZAR TERRAFORM <<<${NC}"
    exit 1
fi