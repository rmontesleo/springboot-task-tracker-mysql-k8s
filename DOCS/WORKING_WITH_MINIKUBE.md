

###
```bash
# create the namespaces
kubectl apply -f k8s/02-01-namespace.yaml
kubectl get ns

# create an ubuntu pod to check some services
kubeclt apply -f k8s/02-02-ubuntu-pod.yaml 

# Create the configmap
kubectl apply -f k8s/02-03-configmap.yaml

# Create api secrets
kubectl apply -f k8s/02-04-api-secrets.yaml 

# Create db secrets
kubectl apply -f k8s/02-05-db-secrets.yaml 



```

### settings for ubuntu pod
```bash
apt-get -y update && apt-get -y install curl iputils-ping jq
```