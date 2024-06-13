#!/bin/bash

# Check HELM chart
# echo "Checking"
# cd ../HELM && helm lint 

# Cleanup dev environment
kubectl delete all --all -n development
kubectl delete namespace development
helm uninstall dev-chart

# Cleanup prod environment
kubectl delete all --all -n production
kubectl delete namespace production
helm uninstall prod-chart

echo "Deploying..."

# Install HELM chart for dev environment
helm install dev-chart ./HELM --values=values-dev.yaml

# Install HELM chart for dev environment
helm install prod-chart ./HELM --values=values-prod.yaml

echo "All resources have been deployed." 
