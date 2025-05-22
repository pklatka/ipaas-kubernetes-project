# Dockerfile that automates adding datasource and dashboard provisioning to Grafana
FROM docker.io/grafana/grafana:9.4.7

USER root

# Create provisioning directories
RUN mkdir -p /etc/grafana/provisioning/datasources \
             /etc/grafana/provisioning/dashboards \
             /var/lib/grafana/dashboards

# Copy our provisioning configs
COPY provisioning/datasources.yaml /etc/grafana/provisioning/datasources/datasources.yaml
COPY provisioning/dashboards.yaml  /etc/grafana/provisioning/dashboards/dashboards.yaml

# Fetch the dashboard JSON from grafana.com and place it into the dashboards folder
COPY provisioning/16248.json /var/lib/grafana/dashboards/16248.json


# Ensure correct permissions
# RUN chown -R grafana:grafana /etc/grafana/provisioning /var/lib/grafana/dashboards

# Switch back to the grafana user
USER grafana

# (Optional) Expose port if you’re not already exposing it upstream
EXPOSE 3000

# Entrypoint is inherited from the base image
