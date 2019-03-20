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

Create and start cluster
```bash
minikube start --vm-driver hyperkit
```

```bash
terraform init
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