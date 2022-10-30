#!/bin/bash

### conntrack: install
apt install conntrack

### kubectl: install
curl --silent -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.13/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

### minikube: install
curl --silent -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

### minikube: start
su - ubuntu -c "minikube start --kubernetes-version=v1.23.13 --nodes=3"
su - ubuntu -c "minikube addons enable ingress"
su - ubuntu -c "minikube status"
