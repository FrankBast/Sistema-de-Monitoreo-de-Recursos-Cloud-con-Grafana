# Pruebas de Monitoreo - Matriz (Plantilla)

| ID  | Escenario | Pasos (instrucciones) | Resultado esperado | Resultado real | Captura (archivo) | Ajuste aplicado | Commit / Versión |
|-----|-----------|------------------------|--------------------|----------------|-------------------|-----------------|------------------|
| P-001 | Normal (todo OK) | 1) Verificar dashboard X 2) Revisar panel Y | KPI dentro de rango | KPI dentro de rango | screenshots/P-001_ok.png | Ninguno | abc1234 |
| P-002 | CPU alta | 1) Ejecutar `stress -c 2 -t 120` en VM1 2) Observar panel CPU | CPU > 75% por >2m y alerta CRITICAL | CPU 80% alerta disparada | screenshots/P-002_cpu.png | Ajuste umbral CPU -> 85% (branch: fix/cpu-threshold) |  def5678 |

