# Demo Deployment

## Configuration Setup

### 1. Environment Preparation

```bash
# Set up demo environment
./scripts/setup-demo-env.sh

# Verify environment
./scripts/verify-demo-env.sh
```

### 2. Component Configuration

#### KWOK Configuration
```yaml
# config/kwok/demo-config.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: kwok-demo-config
data:
  nodes: "500"  # Demo scale
  pods-per-node: "5"
  update-frequency: "2s"
```

#### Observability Stack Configuration
```yaml
# config/monitoring/demo-values.yaml
prometheus:
  retention: "24h"
  resources:
    requests:
      memory: "1Gi"
      cpu: "500m"
    limits:
      memory: "2Gi"
      cpu: "1000m"

grafana:
  adminPassword: "demo123"
  resources:
    requests:
      memory: "512Mi"
      cpu: "250m"
    limits:
      memory: "1Gi"
      cpu: "500m"
```

## Data Preparation

### 1. Test Data Generation

```bash
# Generate test data
./scripts/generate-test-data.sh

# Verify data generation
./scripts/verify-test-data.sh
```

### 2. Sample Workloads

```bash
# Deploy sample workloads
./scripts/deploy-sample-workloads.sh

# Verify workload deployment
kubectl get pods -n demo-workloads
```

## Execution Procedure

### 1. Start Demo Environment

```bash
# Start KWOK cluster
./scripts/start-demo-cluster.sh

# Deploy observability stack
./scripts/deploy-demo-stack.sh
```

### 2. Run Demo Scenarios

#### Basic Monitoring
```bash
# Deploy basic monitoring scenario
./scripts/run-basic-monitoring.sh

# Monitor results
./scripts/monitor-basic-scenario.sh
```

#### Load Testing
```bash
# Deploy load test scenario
./scripts/run-load-test.sh

# Monitor load test
./scripts/monitor-load-test.sh
```

#### Failure Simulation
```bash
# Deploy failure scenario
./scripts/run-failure-scenario.sh

# Monitor recovery
./scripts/monitor-recovery.sh
```

## Results Presentation

### 1. Dashboard Setup

```bash
# Import demo dashboards
./scripts/import-demo-dashboards.sh

# Configure demo views
./scripts/configure-demo-views.sh
```

### 2. Metrics Visualization

#### Node Metrics
```bash
# View node metrics
./scripts/view-node-metrics.sh

# Export node metrics
./scripts/export-node-metrics.sh
```

#### Pod Metrics
```bash
# View pod metrics
./scripts/view-pod-metrics.sh

# Export pod metrics
./scripts/export-pod-metrics.sh
```

### 3. Performance Analysis

```bash
# Generate performance report
./scripts/generate-demo-report.sh

# View performance metrics
./scripts/view-performance-metrics.sh
```

## Demo Walkthrough

### 1. Initial Setup

1. **Cluster Overview**
   - Show KWOK cluster status
   - Display node distribution
   - Present pod distribution

2. **Observability Stack**
   - Show component status
   - Display data flow
   - Present initial metrics

### 2. Monitoring Demonstration

1. **Real-time Monitoring**
   - Show live metrics
   - Display alert status
   - Present dashboard views

2. **Historical Data**
   - Show historical trends
   - Display pattern analysis
   - Present correlation views

### 3. Scaling Demonstration

1. **Node Scaling**
   - Show node addition
   - Display workload distribution
   - Present performance impact

2. **Workload Scaling**
   - Show pod scaling
   - Display resource utilization
   - Present response times

### 4. Failure Handling

1. **Failure Simulation**
   - Show node failure
   - Display pod failure
   - Present service impact

2. **Recovery Process**
   - Show automatic recovery
   - Display manual intervention
   - Present system stability

## Cleanup

```bash
# Clean up demo environment
./scripts/cleanup-demo.sh

# Verify cleanup
./scripts/verify-cleanup.sh
```

## Troubleshooting

### Common Demo Issues

1. **Performance Issues**
   ```bash
   # Check performance
   ./scripts/check-demo-performance.sh
   ```

2. **Visualization Issues**
   ```bash
   # Check visualization
   ./scripts/check-demo-visualization.sh
   ```

3. **Data Collection Issues**
   ```bash
   # Check data collection
   ./scripts/check-demo-data.sh
   ```

### Demo Recovery

```bash
# Reset demo environment
./scripts/reset-demo.sh

# Verify reset
./scripts/verify-demo-reset.sh
``` 