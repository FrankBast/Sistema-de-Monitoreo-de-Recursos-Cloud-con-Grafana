# Pruebas de Monitoreo - Matriz

| ID     | Escenario              | Pasos (instrucciones) | Resultado esperado | Resultado real | Captura (archivo) | Ajuste aplicado | Commit / Versión |
|--------|------------------------|-----------------------|--------------------|----------------|-------------------|-----------------|------------------|
| P-001  | Normal (todo OK)       | 1) Verificar panel Quick CPU/Mem/Disk <br> 2) Revisar gráficos básicos | KPI dentro de rango | CPU Busy 3.8%, RAM Used 7.7% (~158MB/2GB), SWAP 0%, Disco 25.7%, sin alertas | screenshots/P-001_normal.png | Ninguno | v1.1 |
| P-002  | CPU Alta               | 1) Ejecutar `stress -c 2 -t 180` <br> 2) Observar panel CPU | CPU > 75% por >2m y alerta CRITICAL | CPU 91%, Load 2.15, alerta crítica activada en 45s | screenshots/P-002_cpu.png | Ajuste umbral CPU -> 85% sostenido 2m (branch: fix/cpu-threshold) | v1.2 |
| P-003  | RAM Alta               | 1) Ejecutar `stress --vm 1 --vm-bytes 1600M --timeout 180s` <br> 2) Observar panel RAM | RAM > 100% (>2.0GB) y alerta CRITICAL | RAM 1.82GB (91%), SWAP 5%, alerta WARNING activada | Screenshots/Alto Uso de Ram (Actualizado) Screenshot 2026-02-16.jpeg | Ajuste severidad a CRITICAL >90% (branch: fix/ram-threshold) | v1.2 |
| P-004  | Servicio detenido      | 1) Ejecutar `systemctl stop nginx` <br> 2) Validar disponibilidad | Servicio DOWN y alerta crítica inmediata | Estado DOWN, disponibilidad 0%, alerta generada en 30s | screenshots/P-004_service_down.png | Reducción evaluación alerta a 30s (branch: fix/service-alert) | v1.3 |
| P-005  | Servicio restablecido  | 1) Ejecutar `systemctl start nginx` <br> 2) Validar recuperación | Servicio UP y cierre automático de alerta | Servicio UP, disponibilidad 100%, alerta cerrada en 25s | screenshots/P-005_service_up.png | Ninguno | v1.3 |


