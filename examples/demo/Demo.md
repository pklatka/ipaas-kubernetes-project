## Starting kwok cluster

Create a cluster  
```kwokctl create cluster --name=kwok --prometheus-port 9090 --jaeger-port 16686 --enable metrics-server -c metrics-usage.yaml```
And then we switch the context  
```kubectl config use-context kwok-kwok```

## Grafana

### Manual Setup
Run grafana container to monitor the cluster  
```docker run -d --name=grafana -p 3000:3000 docker.io/grafana/grafana:9.4.7```
- Add the Prometheus data source, http://host.docker.internal:9090
- Add the Jaeger data source, http://host.docker.internal:16686 and turn on 'Enable Node Graph'
- Import dashboard via grafana.com code 16248 on Grafana.

### Using custom Dockerfile
```docker build -t my-grafana:9.4.7 .```
```docker run -d --name=grafana -p 3000:3000 my-grafana:9.4.7```

### Accessing Grafana
- Open your web browser and go to http://localhost:3000
- On the login page, enter admin for username and password.

### Running example deployment

1. Set up number of replicas
```kwokctl scale node --replicas 5000```

2. Run the deployment
```kubectl apply -f deployment.yaml```

3. Stopping the deployment
```kubectl delete deployment kwok-benchmark-app```


### Stopping the cluster
```kwokctl delete cluster --name=kwok```
