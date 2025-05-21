# Environment Configuration

## System Requirements

### Hardware Requirements
- CPU: Minimum 4 cores (8+ cores recommended)
- RAM: Minimum 8GB (16GB+ recommended)
- Storage: Minimum 50GB free space
- Network: Stable internet connection

### Software Requirements
- Operating System: Linux (Ubuntu 20.04+ recommended)
- Docker: Latest stable version
- Kubernetes: v1.24 or later
- kubectl: Latest version
- Helm: v3.0 or later

## KWOK Configuration

### Basic Setup
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: kwok-config
data:
  nodes: "1000"  # Number of simulated nodes
  pods-per-node: "10"  # Number of pods per node
  update-frequency: "1s"  # Status update frequency
```

### Node Configuration
```yaml
apiVersion: v1
kind: Node
metadata:
  name: kwok-node-1
spec:
  capacity:
    cpu: "4"
    memory: "8Gi"
    pods: "110"
```

## Observability Stack Configuration

### OpenTelemetry Collector
```yaml
apiVersion: opentelemetry.io/v1alpha1
kind: OpenTelemetryCollector
metadata:
  name: otel-collector
spec:
  mode: deployment
  config: |
    receivers:
      otlp:
        protocols:
          grpc:
          http:
    processors:
      batch:
    exporters:
      prometheus:
        endpoint: "prometheus:9090"
      loki:
        endpoint: "loki:3100"
      jaeger:
        endpoint: "jaeger:14250"
```

### Prometheus Configuration
```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: prometheus
spec:
  endpoints:
    - port: metrics
      interval: 15s
  selector:
    matchLabels:
      app: prometheus
```

### Grafana Configuration
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: grafana-datasources
data:
  prometheus.yaml: |
    apiVersion: 1
    datasources:
      - name: Prometheus
        type: prometheus
        url: http://prometheus:9090
        access: proxy
```

## Network Configuration

### Ingress Setup
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: observability-ingress
spec:
  rules:
    - host: grafana.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: grafana
                port:
                  number: 80
```

## Security Configuration

### RBAC Setup
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: observability-role
rules:
  - apiGroups: [""]
    resources: ["pods", "services", "nodes"]
    verbs: ["get", "list", "watch"]
```

## Monitoring Configuration

### Alert Rules
```yaml
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: observability-alerts
spec:
  groups:
    - name: observability
      rules:
        - alert: HighMemoryUsage
          expr: node_memory_usage_percent > 85
          for: 5m
          labels:
            severity: warning
```

## Backup Configuration

### Data Retention
```yaml
apiVersion: monitoring.coreos.com/v1
kind: Prometheus
metadata:
  name: prometheus
spec:
  retention: 15d
  storage:
    volumeClaimTemplate:
      spec:
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: 50Gi
``` 