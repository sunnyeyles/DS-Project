#!/bin/bash

# Check HELM chart
cd ../HELM && helm lint 

# Cleanup dev environment
kubectl delete all --all -n development
kubectl delete namespace development
helm uninstall dev-chart

# Cleanup prod environment
kubectl delete all --all -n production
kubectl delete namespace production
helm uninstall prod-chart

# Install HELM chart for dev environment
helm install -f dev-chart ../HELM values-dev.yaml

# Install HELM chart for prod environment
helm install -f prod-chart ../HELM values-dev.yaml

echo "All resources have been deployed." 
