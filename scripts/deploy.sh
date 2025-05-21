#!/bin/bash

set -e

# Create monitoring namespace
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

# Add Prometheus Helm repository
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Install Prometheus stack
helm upgrade --install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --values config/prometheus/prometheus-values.yaml \
  --wait

# Install OpenTelemetry Collector
kubectl apply -f config/opentelemetry/otel-collector.yaml

# Apply Kubernetes monitoring configuration
kubectl apply -f config/monitoring/k8s-monitoring.yaml

# Wait for all pods to be ready
echo "Waiting for all pods to be ready..."
kubectl wait --for=condition=ready pod --all -n monitoring --timeout=300s

# Get Grafana admin password
echo "Grafana admin password: admin"

# Get service URLs
echo "Grafana URL: http://localhost:3000"
echo "Prometheus URL: http://localhost:9090"
echo "AlertManager URL: http://localhost:9093"

# Port-forward services
echo "Setting up port forwarding..."
kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80 &
kubectl port-forward -n monitoring svc/prometheus-server 9090:9090 &
kubectl port-forward -n monitoring svc/prometheus-alertmanager 9093:9093 &

echo "Deployment completed successfully!" 