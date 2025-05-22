## Installing kwok

- Homebrew  
```brew install kwok```

## Starting kwok cluster

Create a cluster  
```kwokctl create cluster --name=kwok --prometheus-port 9090```

Run grafana container to monitor the cluster  
```docker run -d --name=grafana -p 3000:3000 docker.io/grafana/grafana:9.4.7```

And then we switch the context  
```kubectl config use-context kwok-kwok```

TODO: some of this proprably can be automated with custom Dockerfile
- Open your web browser and go to http://localhost:3000
- On the login page, enter admin for username and password.
- Add the Prometheus data source, http://host.docker.internal:9090
- Import dashboard via grafana.com code 16248 on Grafana.
