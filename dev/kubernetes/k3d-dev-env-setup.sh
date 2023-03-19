#! /bin/bash

mkdir ~/.kube


k3d registry \
    create mlflow-registry.localhost \
    --port 12000


k3d cluster \
    create mlflow \
    --registry-use k3d-mlflow-registry.localhost:12000 \
    --agents 1 \
    -p "32000-32010:32000-32010@server:0"


# Todo: remove and add to documentation
k3d kubeconfig get mlflow > $HOME/.kube/config


bash dev/kubernetes/build-image.sh
