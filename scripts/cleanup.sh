#!/bin/bash

set -e

echo "Cleaning up monitoring stack..."

# Delete port-forward processes
pkill -f "kubectl port-forward" || true

# Delete monitoring resources
kubectl delete -f config/monitoring/k8s-monitoring.yaml --ignore-not-found
kubectl delete -f config/opentelemetry/otel-collector.yaml --ignore-not-found

# Uninstall Prometheus stack
helm uninstall prometheus -n monitoring

# Delete monitoring namespace
kubectl delete namespace monitoring --ignore-not-found

echo "Cleanup completed successfully!" 