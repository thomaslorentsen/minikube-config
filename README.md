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
minikube start --vm-driver hyperkit --extra-config=apiserver.Authorization.Mode=RBAC
```

```bash
terraform init
```

```bash
kubectl apply -f eks-admin-service-account.yaml
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
```

## Helm
Install tiller
```bash
helm init --tiller-image gcr.io/kubernetes-helm/tiller:v2.13.1
helm repo update
sleep 30
```

Install [Kube Dashboard](https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html)
```bash
helm --namespace=kube-system install stable/kubernetes-dashboard
export POD_NAME=$(kubectl get pods -n kube-system -l "app=kubernetes-dashboard,release=k8s-dashboard" -o jsonpath="{.items[0].metadata.name}")
echo https://127.0.0.1:8443/
kubectl -n kube-system port-forward $POD_NAME 8443:8443
```

```bash
helm install --name my-service charts/simple
helm upgrade --atomic my-service charts/simple
helm status my-service
helm delete --purge my-service
```

```bash
export POD_NAME=$(kubectl get pods -n default -l "app.kubernetes.io/instance=my-service" -o jsonpath="{.items[0].metadata.name}")
kubectl -n default port-forward my-service-simple-6b49847956-fj9j8 8008:80
```

## Nginx

```bash
minikube addons enable ingress
```
Wait a minute
```bash
kubectl get pods -n kube-system -l "app.kubernetes.io/name=nginx-ingress-controller"
```

```bash
minikube service my-service-simple --url
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