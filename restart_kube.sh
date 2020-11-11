#!/bin/bash
NAMESPACE=$1
DEPLOYMENT=$2

helm delete $DEPLOYMENT --namespace $NAMESPACE
#helm install $DEPLOYMENT airflow-stable/airflow --version 7.14.0 --namespace $NAMESPACE --values ./custom_values.yaml
helm install $DEPLOYMENT /Users/isaiahturner/Desktop/StellarWorkspace/charts/charts/airflow --namespace $NAMESPACE --values ./custom_values.yaml

sleep 10
export POD_NAME=$(kubectl get pods --namespace $NAMESPACE -l "component=web,app=airflow" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward --namespace $NAMESPACE $POD_NAME 8080:8080