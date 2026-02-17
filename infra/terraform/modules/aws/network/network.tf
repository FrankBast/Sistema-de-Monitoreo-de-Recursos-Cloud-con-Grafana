# ==============================================================================
# TOPOLOGÍA DE RED (ANSD)
# Propósito: Definir la VPC, Subred Pública y Enrutamiento a Internet
# ==============================================================================

# 1. LA VPC (La Red Privada Virtual)
# ------------------------------------------------------------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true # Necesario para resolver dominios externos (ej: github.com)
  enable_dns_hostnames = true # Asigna nombres DNS de AWS a las instancias

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# 2. INTERNET GATEWAY (La Puerta al Mundo)
# ------------------------------------------------------------------------------
# Sin esto, los servidores no pueden descargar Docker ni conectarse a Cloudflare
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# 3. LA SUBRED (Donde viven las VMs)
# ------------------------------------------------------------------------------
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true # Asigna IP pública automáticamente (Vital para SSH directo)
  availability_zone       = "${var.aws_region}a" # Forzamos la zona 'a' para simplicidad

  tags = {
    Name = "${var.project_name}-public-subnet"
  }
}

# 4. TABLA DE ENRUTAMIENTO (El Mapa de Tráfico)
# ------------------------------------------------------------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  # Regla: Todo lo que no sea local (0.0.0.0/0), mándalo al Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# 5. ASOCIACIÓN DE RUTA
# ------------------------------------------------------------------------------
# Conectamos la subred con la tabla de enrutamiento para aplicar las reglas
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}