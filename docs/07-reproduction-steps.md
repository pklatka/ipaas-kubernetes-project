# Reproduction steps

This document outlines the steps to reproduce the KWOK testing environment where we deploy the online-boutique microservices application. The online-boutique is a cloud-native microservices demo application that consists of multiple services, making it an ideal candidate for testing large-scale Kubernetes deployments in KWOK.

![Online Boutique](./images/online-boutique-architecture.png)

## Steps

1. Create a cluster  
```kwokctl create cluster --name=kwok --prometheus-port 9090 --jaeger-port 16686 --enable metrics-server -c ./config/metrics-server/metrics-usage.yaml```

2. Switch the context  
```kubectl config use-context kwok-kwok```

3. Run grafana container to monitor the cluster  
```docker run -d --name=grafana -p 3000:3000 docker.io/grafana/grafana:9.4.7```

4. Set up number of replicas
```kwokctl scale node --replicas 12100```

5. Run the deployment
```kubectl apply -f ./examples/online-boutique/online-boutique-deployment.yaml```

6. Stopping the cluster
```kwokctl delete cluster --name=kwok```
