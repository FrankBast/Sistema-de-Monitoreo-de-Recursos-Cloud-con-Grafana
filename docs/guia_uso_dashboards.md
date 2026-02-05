# Guía de Uso del Dashboard de Monitoreo (Explicación (Borrar despues)

## 1. Introducción
Este documento describe cómo interpretar los dashboards de monitoreo y
qué acciones tomar ante métricas fuera de los rangos esperados. Está
dirigido a operadores técnicos y personal de supervisión.

---

## 2. Cómo leer los gráficos
- **CPU (%)**: muestra el uso del procesador a lo largo del tiempo.
- **Memoria RAM**: indica el consumo de memoria del sistema.
- **Disco**: refleja el espacio disponible y utilizado.
- **Estado del servicio**: indica si el servicio está operativo.

---

## 3. Significado de colores y estados
- 🟢 Verde: funcionamiento normal.
- 🟡 Amarillo: advertencia, requiere seguimiento.
- 🔴 Rojo: estado crítico, posible incidente.

---

## 4. Qué hacer cuando una métrica es crítica
- **CPU alta**: verificar procesos activos y carga del sistema.
- **Disco bajo**: revisar almacenamiento y liberar espacio.
- **Servicio caído**: validar conectividad y estado del servicio.

---

## 5. Evidencia visual
- Figura 1: Dashboard en estado normal (screenshots/dashboard_estado_normal.png)
- Figura 2: CPU en estado crítico (screenshots/dashboard_cpu_critica.png)
- Figura 3: Alerta por caída de servicio (screenshots/alerta_servicio_caido.png)

