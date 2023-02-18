#! /bin/bash

helm -n mlflow \
    upgrade \
    --install \
    mlflow-quickstart \
    charts/mlflow-quickstart \
    --set minio.persistence.storageClass=local-path \
    --set mlflow.image.repository=k3d-mlflow-registry.localhost:12000/mlflow/mlflow \
    --set mlflow.image.pullPolicy=Always

