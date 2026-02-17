# ==============================================================================
# SALIDAS DEL MÓDULO DE RED
# Propósito: Exportar IDs de recursos para que otros módulos (Compute) los usen
# ==============================================================================

output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID de la subred pública para colocar las instancias"
  value       = aws_subnet.public.id
}

# --- SECURITY GROUPS ---

output "internal_sg_id" {
  description = "ID del Security Group para tráfico interno (10.0.0.0/16)"
  value       = aws_security_group.internal.id
}

output "admin_sg_id" {
  description = "ID del Security Group para administración SSH (Tu IP)"
  value       = aws_security_group.admin.id
}
