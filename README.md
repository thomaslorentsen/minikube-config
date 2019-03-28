# minikube-config
Configure Kubernetes in Code

# Prerequisites
## Local Development
Install [Hyperkit driver](https://github.com/kubernetes/minikube/blob/master/docs/drivers.md#hyperkit-driver) with brew
```bash
brew install docker-machine-driver-hyperkit
```

Install [minikube](https://github.com/kubernetes/minikube)
```bash
brew cask install minikube
```

Install Helm
```bash
brew install kubernetes-helm
```

Create and start cluster
```bash
minikube start --vm-driver hyperkit
```

```bash
terraform init
```

```bash
kubectl apply -f eks-admin-service-account.yaml
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
```

```bash
oc project kube-system
helm init --history-max 200
helm repo update
helm install stable/kubernetes-dashboard
export POD_NAME=$(kubectl get pods -n kube-system -l "app=kubernetes-dashboard,release=wondering-lizard" -o jsonpath="{.items[0].metadata.name}")
kubectl -n kube-system port-forward $POD_NAME 8443:8443
```

```bash
oc project default
helm install --name my-service charts/simple
helm upgrade my-service charts/simple
helm status my-service
helm delete my-service
```

```bash
export POD_NAME=$(kubectl get pods -n default -l "app.kubernetes.io/instance=my-service" -o jsonpath="{.items[0].metadata.name}")
kubectl -n default port-forward my-service-simple-6b49847956-fj9j8 8008:80
```

# Usage

```bash
terraform plan
terraform apply
```

# Tearing Down
## Local Development

Stop and delete cluster
```bash
minikube stop
minikube delete
```