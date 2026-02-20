# Inventario de Infraestructura AWS - Simulación v1

Este documento contiene el detalle técnico de las instancias EC2 desplegadas en la región `us-east-1` (Norte de Virginia) para el proyecto actual.

## Detalle de Instancias EC2

| Nombre de Instancia | ID de Instancia | Estado | Tipo | Zona de Disponibilidad | IP Pública (IPv4) | Monitoreo | Lanzamiento (GMT-6) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `ansd-simulation-v1-instance-1` | `i-09a6e1f749900e66f` | Running | t2.micro | us-east-1a | 44.200.226.219 | Disabled | 2026/02/16 19:52 |
| `ansd-simulation-v1-instance-2` | `i-08438586cc287f381` | Running | t2.micro | us-east-1a | 44.204.248.189 | Disabled | 2026/02/16 19:52 |
| `ansd-simulation-v1-instance-3` | `i-0fc0ef0984896b344` | Running | t2.micro | us-east-1a | 44.202.221.151 | Disabled | 2026/02/16 19:52 |
| `ansd-simulation-v1-instance-4` | `i-035d4534ee23e24d3` | Running | t2.micro | us-east-1a | 100.27.46.191 | Disabled | 2026/02/16 19:52 |

## Configuración de Red y Seguridad

- **Security Group:** `ansd-simulation-v1-admin-sg`
- **Plataforma:** Linux/UNIX
- **Comprobaciones de estado:** 2/2 (Passed)
- **Administrada por SSM:** No

---
*Última actualización: 20 de febrero de 2026*
