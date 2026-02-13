# Pruebas de Monitoreo - Matriz 

| ID  | Escenario | Pasos (instrucciones) | Resultado esperado | Resultado real | Captura (archivo) | Ajuste aplicado | Commit / Versión |
|-----|-----------|------------------------|--------------------|----------------|-------------------|-----------------|------------------|
| P-001 | Normal (todo OK) | 1) Verificar panel Quick CPU/Mem/Disk 2) Revisar gráficos básicos| KPI dentro de rango | CPU Busy 3.8%, RAM Used 7.7%, Disco 25.7%, sin alertas | Screenshots/Image 2026-02-11 at 3.47.37 PM.jpeg | Ninguno | v1.1 |
| P-002 | CPU alta | 1) Ejecutar `stress -c 2 -t 120` en VM1 2) Observar panel CPU | CPU > 75% por >2m y alerta CRITICAL | CPU 80% alerta disparada | screenshots/P-002_cpu.png | Ajuste umbral CPU -> 85% (branch: fix/cpu-threshold) |  v1.1|

