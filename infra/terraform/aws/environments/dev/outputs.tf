# ==============================================================================
# SALIDAS DEL ENTORNO (OUTPUTS)
# Propósito: Mostrar información útil al finalizar el despliegue
# ==============================================================================

output "resumen_conectividad" {
  description = "IPs Públicas y Privadas para acceso SSH"
  value = {
    for name, info in module.compute.node_details : name => {
      public_ip  = info.public_ip
      private_ip = info.private_ip
      ssh_cmd    = "ssh -i ../../../secret/ansd_key.pem ${var.ansd_custom_user}@${info.public_ip}"
    }
  }
}

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.network.vpc_id
}

output "dashboard_url" {
  description = "Link directo al Dashboard de CloudWatch (Aproximado)"
  value       = "https://console.aws.amazon.com/cloudwatch/home?region=${var.aws_region}#dashboards:name=${var.project_name}-health"
}