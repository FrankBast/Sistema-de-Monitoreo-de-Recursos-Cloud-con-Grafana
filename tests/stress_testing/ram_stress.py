import time
import sys

# Configuración: Cantidad de RAM a consumir en MB
MB_TO_CONSUME = 500 
DURATION_SECONDS = 60

print(f"🌊 Iniciando prueba de estrés de RAM...")
print(f"Asignando {MB_TO_CONSUME}MB de memoria...")

try:
    # Crear un string gigante ocupa memoria RAM real
    dummy_buffer = ' ' * (MB_TO_CONSUME * 1024 * 1024)
    print(f"✅ Memoria asignada. Manteniendo por {DURATION_SECONDS} segundos.")
    print("Revisa si tu gráfica de RAM en Grafana sube.")
    
    time.sleep(DURATION_SECONDS)
    
    print("⏳ Tiempo finalizado. Liberando memoria.")
except MemoryError:
    print("❌ Error: No hay suficiente RAM disponible para esta prueba.")
