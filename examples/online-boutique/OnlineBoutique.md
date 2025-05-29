## Local app setup

1. Launch a local Kubernetes cluster with one of the following tools:

    - To launch **Minikube** (<u>tested with Ubuntu Linux</u>). Please, ensure that the
       local Kubernetes cluster has at least:
        - 4 CPUs
        - 4.0 GiB memory
        - 32 GB disk space

      ```shell
      minikube start --cpus=4 --memory 4096 --disk-size 32g
      ```

    - To launch **Docker for Desktop** (<u>tested with Mac/Windows</u>). Go to Preferences:
        - choose “Enable Kubernetes”,
        - set CPUs to at least 3, and Memory to at least 6.0 GiB
        - on the "Disk" tab, set at least 32 GB disk space

    - To launch a **Kind** cluster:

      ```shell
      kind create cluster
      ```

2. Run `kubectl get nodes` to verify you're connected to the respective control plane.

3. Run `skaffold run` (first time will be slow, it can take ~20 minutes).
   This will build and deploy the application. If you need to rebuild the images
   automatically as you refactor the code, run `skaffold dev` command. 
   
> [!NOTE]
> If you're building on ARM-based machine, you need to modify the Dockerfile in src/cartservice/Dockerfile to use linux-arm64

4. Run `kubectl get pods` to verify the Pods are ready and running.

5. Run `kubectl port-forward deployment/frontend 8080:8080` to forward a port to the frontend service.

6. Navigate to `localhost:8080` to access the web frontend.

## KWOK deployment

1. Create a cluster  
```kwokctl create cluster --name=kwok --prometheus-port 9090 --jaeger-port 16686 --enable metrics-server -c ./config/metrics-server/metrics-usage.yaml```

2. Switch the context  
```kubectl config use-context kwok-kwok```

3. Run grafana container to monitor the cluster  
```docker run -d --name=grafana -p 3000:3000 docker.io/grafana/grafana:9.4.7```

4. Set up number of replicas
```kwokctl scale node --replicas 12100```

5. Run the deployment
```kubectl apply -f online-boutique-deployment.yaml```

6. Stopping the cluster
```kwokctl delete cluster --name=kwok```
