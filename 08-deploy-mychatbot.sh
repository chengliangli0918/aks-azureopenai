#!/bin/bash

# Variables
source ./set-variables.sh

echo $image
export KUBECONFIG=$aksKubeConfigPath
# Attach ACR to AKS cluster
if [[ $attachAcr == true ]]; then
  echo "Attaching ACR $acrName to AKS cluster $aksClusterName..."
  az aks update \
    --name $aksClusterName \
    --resource-group $aksResourceGroupName \
    --attach-acr $acrName
fi

# Check if namespace exists in the cluster
result=$(kubectl get namespace -o jsonpath="{.items[?(@.metadata.name=='$namespace')].metadata.name}")

if [[ -n $result ]]; then
  echo "$namespace namespace already exists in the cluster"
else
  echo "$namespace namespace does not exist in the cluster"
  echo "creating $namespace namespace in the cluster..."
  kubectl create namespace $namespace
fi

# Create deployment
cat $deploymentTemplate |
    yq "(.spec.template.spec.containers[0].image)|="\""$image"\" |
    yq "(.spec.template.spec.containers[0].imagePullPolicy)|="\""$imagePullPolicy"\" |
    yq "(.spec.template.spec.serviceAccountName)|="\""$serviceAccountName"\" |
    yq "(.spec.template.spec.containers[0].env[0].value)|="\""$title"\" |
    yq "(.spec.template.spec.containers[0].env[1].value)|="\""$label"\" |
    yq "(.spec.template.spec.containers[0].env[2].value)|="\""$temperature"\" |
    yq "(.spec.template.spec.containers[0].env[3].value)|="\""$imageWidth"\" |
    yq "(.spec.template.spec.containers[0].env[4].value)|="\""$openAiType"\" |
    yq "(.spec.template.spec.containers[0].env[5].value)|="\""$openAiBase"\" |
    yq "(.spec.template.spec.containers[0].env[6].value)|="\""$openAiModel"\" |
    yq "(.spec.template.spec.containers[0].env[7].value)|="\""$openAiDeployment"\" |
    kubectl apply -n $namespace -f -

# Create deployment
kubectl apply -f $serviceTemplate -n $namespace