ARG GRAFANA_VERSION=9.5.2

FROM grafana/grafana:$GRAFANA_VERSION

COPY config/grafana-datasources.yml /etc/grafana/provisioning/datasources/provisioning-datasources.yaml
COPY config/grafana-dashboards.yml /etc/grafana/provisioning/dashboards/provisioning-dashboards.yaml
COPY config/dashboards/grafana-dashboard-container-metrics.json /var/lib/grafana/dashboards/container-metrics.json
COPY config/dashboards/grafana-dashboard-node-metrics.json /var/lib/grafana/dashboards/node-metrics.json

