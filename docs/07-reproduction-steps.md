# Reproduction Steps

## Infrastructure as Code Approach

This project uses Infrastructure as Code (IaC) principles to ensure reproducibility and consistency. All infrastructure components are defined using Kubernetes manifests and Helm charts.

## Prerequisites

1. **Required Tools**
   - kubectl
   - helm
   - git
   - docker
   - make

2. **Required Access**
   - Kubernetes cluster access
   - Docker registry access
   - GitHub repository access

## Step-by-Step Reproduction

### 1. Clone Repository

```bash
# Clone the project repository
git clone https://github.com/your-org/observability-kwok.git
cd observability-kwok
```

### 2. Environment Setup

```bash
# Create necessary namespaces
kubectl create namespace monitoring
kubectl create namespace kwok

# Set up environment variables
export CLUSTER_NAME=observability-cluster
export NAMESPACE=monitoring
```

### 3. KWOK Cluster Setup

```bash
# Deploy KWOK cluster
./scripts/setup-kwok.sh

# Verify KWOK deployment
kubectl get nodes
```

### 4. Observability Stack Deployment

```bash
# Deploy base components
./scripts/deploy-base.sh

# Deploy monitoring stack
./scripts/deploy-monitoring.sh

# Deploy logging stack
./scripts/deploy-logging.sh

# Deploy tracing stack
./scripts/deploy-tracing.sh
```

### 5. Configuration

#### Prometheus Configuration
```bash
# Apply Prometheus configuration
kubectl apply -f config/prometheus/

# Verify Prometheus deployment
kubectl get pods -n monitoring -l app=prometheus
```

#### Grafana Configuration
```bash
# Apply Grafana configuration
kubectl apply -f config/grafana/

# Get Grafana admin password
kubectl get secret -n monitoring grafana-admin -o jsonpath="{.data.password}" | base64 --decode
```

#### OpenTelemetry Configuration
```bash
# Apply OpenTelemetry configuration
kubectl apply -f config/opentelemetry/

# Verify OpenTelemetry deployment
kubectl get pods -n monitoring -l app=otel-collector
```

### 6. Data Generation

```bash
# Deploy test workloads
./scripts/deploy-test-workloads.sh

# Verify workload deployment
kubectl get pods -n test-workloads
```

### 7. Verification

#### Check Component Health
```bash
# Check all component health
./scripts/verify-health.sh
```

#### Verify Data Collection
```bash
# Check Prometheus targets
kubectl port-forward -n monitoring svc/prometheus-server 9090:9090
# Access http://localhost:9090/targets

# Check Grafana dashboards
kubectl port-forward -n monitoring svc/grafana 3000:80
# Access http://localhost:3000
```

## Testing Scenarios

### 1. Load Testing

```bash
# Deploy load test
./scripts/deploy-load-test.sh

# Monitor results
./scripts/monitor-load-test.sh
```

### 2. Scale Testing

```bash
# Scale up nodes
./scripts/scale-nodes.sh 2000

# Monitor scaling
./scripts/monitor-scaling.sh
```

### 3. Failure Testing

```bash
# Deploy failure scenarios
./scripts/deploy-failure-scenarios.sh

# Monitor recovery
./scripts/monitor-recovery.sh
```

## Data Collection

### 1. Metrics Collection

```bash
# Export metrics
./scripts/export-metrics.sh

# Analyze metrics
./scripts/analyze-metrics.sh
```

### 2. Logs Collection

```bash
# Export logs
./scripts/export-logs.sh

# Analyze logs
./scripts/analyze-logs.sh
```

### 3. Traces Collection

```bash
# Export traces
./scripts/export-traces.sh

# Analyze traces
./scripts/analyze-traces.sh
```

## Results Analysis

### 1. Performance Analysis

```bash
# Generate performance report
./scripts/generate-performance-report.sh

# View report
./scripts/view-performance-report.sh
```

### 2. Resource Usage Analysis

```bash
# Generate resource usage report
./scripts/generate-resource-report.sh

# View report
./scripts/view-resource-report.sh
```

## Cleanup

```bash
# Clean up test workloads
./scripts/cleanup-test-workloads.sh

# Clean up monitoring stack
./scripts/cleanup-monitoring.sh

# Clean up KWOK cluster
./scripts/cleanup-kwok.sh
```

## Troubleshooting

### Common Issues

1. **Component Deployment Failures**
   ```bash
   # Check component logs
   ./scripts/check-component-logs.sh <component-name>
   ```

2. **Data Collection Issues**
   ```bash
   # Verify data collection
   ./scripts/verify-data-collection.sh
   ```

3. **Performance Issues**
   ```bash
   # Check performance metrics
   ./scripts/check-performance.sh
   ```

### Debugging Tools

```bash
# Get debug information
./scripts/get-debug-info.sh

# Generate debug report
./scripts/generate-debug-report.sh
``` 