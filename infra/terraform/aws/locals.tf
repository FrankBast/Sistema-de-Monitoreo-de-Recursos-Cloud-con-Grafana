# ==============================================================================
# VARIABLES LOCALES Y CONSTANTES (LOCALS)
# Propósito: Definir valores calculados y etiquetas comunes para todo el proyecto
# ==============================================================================

locals {
  # 1. ETIQUETAS COMUNES (COMMON TAGS)
  # ----------------------------------------------------------------------------
  # Estas etiquetas se fusionarán con las específicas de cada recurso.
  # Ayudan en la auditoría de costos y la gestión de recursos en AWS.
  common_tags = {
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Owner       = "ANSD-Admin"
    CostCenter  = "Infrastructure-Lab"
  }

  # 2. PREFIJO DE NOMBRES (NAMING CONVENTION)
  # ----------------------------------------------------------------------------
  # Usamos esto para que todos los recursos sigan el formato: "ansd-dev-recurso"
  # Nota: terraform.workspace por defecto es "default", pero en entornos avanzados
  # tomaría valores como "dev" o "prod".
  name_prefix = "${var.project_name}-${terraform.workspace}"

  # 3. FECHA DE CREACIÓN ()
  # ----------------------------------------------------------------------------
  # creation_date = timestamp() 
  # (Comentado porque provoca que Terraform quiera actualizar los tags en cada 'apply')

