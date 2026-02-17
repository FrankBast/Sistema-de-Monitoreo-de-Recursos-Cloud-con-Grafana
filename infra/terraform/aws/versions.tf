# ==============================================================================
# VERSIONS.TF - SOLO RESTRICCIONES
# ==============================================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    
    # Otros proveedores opcionales (random, tls, etc.)
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}