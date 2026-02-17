# /opt/proyecto/deployment/terraform/aws/modules/compute/outputs.tf

output "node_details" {
  description = "Mapa detallado de los nodos creados (IDs, IPs, Roles)"
  value = {
    for name, instance in aws_instance.ansd_nodes : name => {
      id         = instance.id
      private_ip = instance.private_ip
      public_ip  = instance.public_ip
      role       = instance.tags.Role
    }
  }
}

# ==============================================================================
# SALIDAS DE CÓMPUTO (IPs Públicas)
# ==============================================================================

output "node_public_ips" {
  description = "Mapa de Nombres de Nodo a IPs Públicas"
  value = {
    for k, v in aws_instance.ansd_nodes : k => v.public_ip
  }
}

output "node_public_dns" {
  description = "DNS Públicos (útil si la IP cambia)"
  value = {
    for k, v in aws_instance.ansd_nodes : k => v.public_dns
  }
}



curl https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list

sudo apt-get update && sudo apt-get install cloudflare-warp