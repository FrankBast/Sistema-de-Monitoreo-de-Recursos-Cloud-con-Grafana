# ==============================================================================
# PROVIDERS.TF - SOLO CONFIGURACIÓN DE AWS
# ==============================================================================

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = "dev" # O podrías usar terraform.workspace si lo prefieres
      ManagedBy   = "Terraform"
      Owner       = "ANSD-Admin"
    }
  }
}