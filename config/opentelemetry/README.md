# Setup OpenTelemetry Collector

1. Create EKS

Follow instructions on the SUU labs from k8s

2. Setup OpenTelemetry Collector on AWS

run ngrok to be able to host outside the prometheus site  
```ngrok http 9090```  
  
3. Create ConfigMap with configuration
```kubectl create configmap otel-collector-config --from-file=otel-collector-config.yaml```

4. Deploy collector to the EKS
```kubectl apply -f otel-collector-deployment.yaml```


