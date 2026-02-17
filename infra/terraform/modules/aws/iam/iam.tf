# ==============================================================================
# DEFINICIÓN DE ROLES Y PERMISOS (IAM)
# ==============================================================================

# 1. EL ROL (La Identidad)
# Definimos quién puede usar este rol: "Servicios EC2"
resource "aws_iam_role" "ansd_node_role" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${var.project_name}-role"
  }
}

# 2. LAS POLÍTICAS (Los Permisos)
# A) AmazonSSMManagedInstanceCore: Permite acceso por consola web (Session Manager)
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ansd_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# B) CloudWatchAgentServerPolicy: Permite enviar métricas y logs
resource "aws_iam_role_policy_attachment" "cloudwatch_policy" {
  role       = aws_iam_role.ansd_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# 3. EL PERFIL DE INSTANCIA (El Enchufe)
# EC2 no puede "usar" un rol directamente, necesita un Instance Profile
resource "aws_iam_instance_profile" "ansd_profile" {
  name = "${var.project_name}-instance-profile"
  role = aws_iam_role.ansd_node_role.name
}