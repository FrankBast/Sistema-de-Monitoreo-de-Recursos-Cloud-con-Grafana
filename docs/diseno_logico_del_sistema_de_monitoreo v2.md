# Diseño Lógico del Sistema de Monitoreo

## 1. Introducción

El presente documento describe el **diseño lógico del sistema de monitoreo implementado**, detallando los componentes involucrados, su interacción y los mecanismos de seguridad aplicados. La arquitectura fue diseñada para garantizar **acceso seguro**, **control de métricas** y **restricción de exposición a Internet**, alineándose a buenas prácticas utilizadas en entornos institucionales y gubernamentales.

---

## 2. Visión general de la arquitectura

La solución de monitoreo se basa en un modelo híbrido controlado, donde:
- El **servidor de monitoreo** se encuentra en la **oficina / Data Center**.
- Los **recursos monitoreados** están alojados en **AWS Cloud**.
- El acceso de usuarios y la visualización de métricas se realiza de forma segura mediante **Cloudflare Zero Trust**.

---

## 3. Componentes de la arquitectura

### 3.1 Usuario remoto
- Accede al sistema de monitoreo utilizando **HTTPS**.
- No tiene acceso directo a los servidores internos.

---

### 3.2 Cloudflare Zero Trust
- Actúa como capa de seguridad perimetral.
- Incluye los siguientes servicios:
  - **Cloudflare WAF**
  - **Cloudflare Access**
- Controla la autenticación, autorización y protección del tráfico entrante.

---

### 3.3 Túnel seguro (Cloudflared Tunnel)
- Permite la conexión segura entre Cloudflare y la infraestructura interna.
- Elimina la necesidad de exponer puertos públicos en el servidor de monitoreo.
- Garantiza cifrado de extremo a extremo.

---

### 3.4 Servidor de Monitoreo (Oficina / Data Center)

Este servidor centraliza la gestión del monitoreo y contiene los siguientes servicios:

- **Grafana**: plataforma de visualización de métricas y dashboards.
- **Prometheus**: motor de recolección y consulta de métricas.
- **Cloudflared**: cliente encargado de mantener el túnel seguro con Cloudflare.

El servidor únicamente se comunica con Internet mediante el túnel seguro y la salida controlada de la oficina.

---

### 3.5 Salida a Internet de la oficina
- Prometheus utiliza la salida a Internet institucional para conectarse a AWS.
- Se emplea una **IP pública fija de la oficina**, utilizada como origen autorizado en AWS.

---

### 3.6 Infraestructura en AWS Cloud

#### 3.6.1 Security Groups
- Se configuraron reglas de seguridad restrictivas.
- Regla principal:
  - Permitir **puerto 9100 (Node Exporter)**
  - **Únicamente desde la IP pública de la oficina**

Esta configuración evita accesos no autorizados desde Internet.

---

#### 3.6.2 Instancias monitoreadas

Las siguientes instancias cuentan con **Node Exporter** para exponer métricas:

- **Web Server + Node Exporter**
- **DB Server + Node Exporter**

Estas instancias no exponen servicios de monitoreo de forma pública.

---

## 4. Flujo lógico de la información

1. El usuario remoto accede a Grafana mediante HTTPS.
2. El tráfico pasa por Cloudflare Zero Trust (WAF y Access).
3. Cloudflare redirige la conexión a través del Cloudflared Tunnel.
4. El usuario visualiza los dashboards alojados en Grafana.
5. Prometheus consulta métricas desde las instancias AWS.
6. AWS permite el acceso únicamente desde la IP pública de la oficina.

---

## 5. Consideraciones de seguridad

- No se exponen puertos internos a Internet.
- Acceso controlado mediante Zero Trust.
- Uso de túneles seguros en lugar de VPN tradicional.
- Restricción de origen por IP en AWS.
- Separación de responsabilidades entre visualización, recolección y recursos productivos.

---

## 6. Beneficios del diseño

- Acceso seguro y centralizado al monitoreo.
- Reducción de superficie de ataque.
- Arquitectura alineada a buenas prácticas institucionales.
- Escalabilidad para incorporar nuevos servidores o métricas.
- Facilidad de auditoría y control de accesos.

---

## 7. Conclusión

El diseño lógico implementado permite una **arquitectura de monitoreo segura, controlada y eficiente**, adecuada para entornos híbridos y de demostración, garantizando visibilidad de los recursos sin comprometer la seguridad de la infraestructura.
