# ==============================================================================
# VARIABLES DEL MÓDULO VISUALS
# ==============================================================================

variable "project_name" {
  description = "Nombre del proyecto para prefijos y etiquetas"
  type        = string
}

variable "instance_details" {
  description = "Mapa con los IDs y detalles de las instancias a monitorear"
  # Debe coincidir con la estructura que sale del módulo compute
  type = map(object({
    id         = string
    private_ip = string
    public_ip  = string
    role       = string
  }))
}
