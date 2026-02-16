├── environments/
│   └── dev/
│       ├── main.tf            # Orquestador: Llama a los módulos y crea targets.json
│       ├── terraform.tfvars   # Credenciales, IPs públicas de admin y tokens
│       ├── variables.tf       # Variables específicas del entorno dev
│       └── targets.json       # (AUTO-GENERADO) Archivo para Prometheus
├── modules/
│   ├── network/
│   │   ├── network.tf         # VPC, Subnets e Internet Gateway
│   │   ├── security.tf        # Security Groups (Puertos 22, 80, 8080, 9100)
│   │   ├── outputs.tf         # Exporta VPC_ID y SG_IDs
│   │   └── variables.tf       # Variables de red
│   ├── compute/
│   │   ├── compute.tf         # Instancias EC2 y Key Pairs
│   │   ├── outputs.tf         # Exporta IPs públicas y Roles para el JSON
│   │   └── variables.tf       # Variables de cómputo
│   └── visuals/               # (Opcional si usas Grafana vía TF)
│       └── variables.tf
├── scripts/                   # PLANTILLAS DE INICIALIZACIÓN (.tftpl)
│   ├── portal.sh.tftpl        # Script Nginx + Node Exporter
│   ├── api.sh.tftpl           # Script API + Node Exporter
│   ├── db.sh.tftpl            # Script Redis + Node Exporter
│   └── tunnel.sh.tftpl        # Script Cloudflare + Node Exporter
└── secret/                    # ARCHIVOS SENSIBLES (Fuera de Git)
    ├── ansd_key               # Llave privada SSH
    └── ansd_key.pub           # Llave pública SSH
