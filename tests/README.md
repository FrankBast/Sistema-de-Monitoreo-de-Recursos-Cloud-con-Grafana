# Pruebas
# Validación y pruebas del monitoreo

## Pruebas realizadas

- Validación de scraping de métricas
- Simulación de CPU alta
- Pruebas de caída de servicio web
- Verificación de alertas

## Resultados esperados

- Visualización correcta en Grafana
- Generación de alertas
- Cumplimiento de SLOs simulados
- 
Una vez que se suba al servidor (o localmente),se debe dar permisos de ejecución:
ej:
Bash
chmod +x tests/stress_testing/*.sh
# El de python se corre con: python3 tests/stress_testing/ram_stress.py
