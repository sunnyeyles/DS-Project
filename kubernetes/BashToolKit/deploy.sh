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

###Install HELM chart for dev environment
# IMPORTANT: credentials are set in environment as follows:
# export atlas_username = <>
# export atlas_password = <>
## Then we can run
helm install test ./HELM --values=./HELM/values-dev.yaml --set MONGO_INITDB_ROOT_USERNAME=${atlas_username},MONGO_INITDB_ROOT_PASSWORD=${atlas_p
assword}

###Install HELM chart for dev environment
# IMPORTANT: credentials are set in environment as follows:
# export atlas_username = <>
# export atlas_password = <>
## Then we can run
helm install test ./HELM --values=./HELM/values-prod.yaml --set MONGO_INITDB_ROOT_USERNAME=${atlas_username},MONGO_INITDB_ROOT_PASSWORD=${atlas_p
assword}

echo "All resources have been deployed." 
