# Installation Guide

## Prerequisites

Before beginning the installation, ensure you have the following prerequisites installed:

1. **Kubernetes Cluster**
   ```bash
   # Verify Kubernetes installation
   kubectl version --client
   ```

2. **Helm**
   ```bash
   # Install Helm
   curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
   ```

3. **Docker**
   ```bash
   # Verify Docker installation
   docker --version
   ```

## Installation Steps

### 1. Install KWOK

```bash
# Clone KWOK repository
git clone https://github.com/kubernetes-sigs/kwok.git
cd kwok

# Install KWOK
make install
```

### 2. Deploy KWOK Cluster

```bash
# Create KWOK cluster
kwokctl create cluster --name observability-cluster --config kwok-config.yaml
```

### 3. Install Observability Stack

#### Add Required Helm Repositories
```bash
# Add Helm repositories
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo update
```

#### Install Prometheus
```bash
# Install Prometheus
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace \
  --values prometheus-values.yaml
```

#### Install OpenTelemetry Collector
```bash
# Install OpenTelemetry Collector
helm install otel-collector open-telemetry/opentelemetry-collector \
  --namespace monitoring \
  --values otel-collector-values.yaml
```

#### Install Grafana
```bash
# Install Grafana
helm install grafana grafana/grafana \
  --namespace monitoring \
  --values grafana-values.yaml
```

### 4. Configure Data Sources

```bash
# Apply Grafana datasource configuration
kubectl apply -f grafana-datasources.yaml
```

### 5. Set Up Ingress

```bash
# Apply ingress configuration
kubectl apply -f ingress.yaml
```

### 6. Configure RBAC

```bash
# Apply RBAC configuration
kubectl apply -f rbac.yaml
```

## Verification Steps

### 1. Verify KWOK Installation
```bash
# Check KWOK nodes
kubectl get nodes
```

### 2. Verify Observability Stack
```bash
# Check all pods in monitoring namespace
kubectl get pods -n monitoring
```

### 3. Verify Grafana Access
```bash
# Get Grafana admin password
kubectl get secret -n monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode
```

## Post-Installation Configuration

### 1. Configure Grafana Dashboards
```bash
# Import default dashboards
kubectl apply -f grafana-dashboards.yaml
```

### 2. Set Up Alerts
```bash
# Apply alert rules
kubectl apply -f prometheus-rules.yaml
```

### 3. Configure Data Retention
```bash
# Apply storage configuration
kubectl apply -f prometheus-storage.yaml
```

## Troubleshooting

### Common Issues

1. **KWOK Nodes Not Showing**
   ```bash
   # Check KWOK logs
   kwokctl logs
   ```

2. **Prometheus Not Scraping**
   ```bash
   # Check Prometheus targets
   kubectl port-forward -n monitoring svc/prometheus-server 9090:9090
   # Access http://localhost:9090/targets
   ```

3. **Grafana Not Accessible**
   ```bash
   # Check Grafana pod logs
   kubectl logs -n monitoring -l app.kubernetes.io/name=grafana
   ```

## Maintenance

### Backup
```bash
# Backup Prometheus data
kubectl exec -n monitoring deploy/prometheus-server -- tar -czf /tmp/backup.tar.gz /prometheus
```

### Updates
```bash
# Update Helm releases
helm upgrade prometheus prometheus-community/kube-prometheus-stack -n monitoring
helm upgrade grafana grafana/grafana -n monitoring
``` 