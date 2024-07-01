**HELM:**
----------------------------------------
This is our current HELM chart which should deploy the backend server pods in a Kubernetes cluster. 

Two environments have been implemented via namespaces:
1. A `development` environment
2. A `production` environment
The goal being to use minimal viable resources for testing in the `development` (no need for maximum availability in that case).

**BashToolKit:**
----------------------------------------

We have two scripts for the purposes of quickly deploying and testing the cluster.
1. deploy.sh    -> deploys all ressources with ./deploy.sh
2. gets.sh      -> gets all the resources with ./gets.sh   

Make the scripts executable via:

chmod +x deploy.sh
chmod +x gets.sh
