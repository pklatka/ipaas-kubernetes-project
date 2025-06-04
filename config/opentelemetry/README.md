# Setup EKS and OpenTelemetry

1. Create EKS and add two nodes

2. Setup kwok using helm on the EKS
```helm repo add kwok https://kwok.sigs.k8s.io/charts/```
```helm repo update```
```helm upgrade --install kwok kwok/kwok --namespace kube-system --create-namespace```
```helm repo update```

3. Install policy chart - stage-fast. It is required to deploy many replicas to the kwok, not the k8s itself.
```helm upgrade --install stage-fast kwok/stage-fast --namespace kube-system```

4. Install OpenTelemetry on the EKS
```helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts```
```helm repo update```

```helm upgrade otel-collector open-telemetry/opentelemetry-collector --namespace opentelemetry -f otel-values.yaml```

5. Install Prometheus and Grafana
```helm repo add prometheus-community https://prometheus-community.github.io/helm-charts```
```helm repo update```
```helm install monitoring prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace```

PROBLEMS
Despite that the application was running properly:
![k8s running app](./images/k8skwokworking.png)

problem occured when dealing with OpenTelemetry:
![k8s running app](./images/optelNotWorking.png)

Also problem with running stage-fast, because deployment was still runing at k8s not kwok.

