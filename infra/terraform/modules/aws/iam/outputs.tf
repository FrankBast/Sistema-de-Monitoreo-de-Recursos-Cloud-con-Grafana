# ==============================================================================
# SALIDAS DEL MÓDULO IAM
# ==============================================================================

output "instance_profile_name" {
  description = "Nombre del perfil de instancia para asociar a las EC2"
  value       = aws_iam_instance_profile.ansd_profile.name
}

output "role_arn" {
  description = "ARN del rol creado (útil para auditoría)"
  value       = aws_iam_role.ansd_node_role.arn
}
