ARG VER
FROM grafana/grafana:${VER}

USER root

# Instalaci  n de plugins necesarios para SLA y reportes
# Se hace en un solo RUN para reducir el tama  o de la imagen final
RUN grafana-cli plugins install grafana-polystat-panel &&     grafana-cli plugins install grafana-clock-panel &&     grafana-cli plugins install gra>

USER grafana
