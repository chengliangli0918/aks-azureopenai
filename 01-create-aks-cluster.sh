#!/bin/bash

# Variables
source ./set-variables.sh

# Check if Azure Kubernetes Service already exists
echo "Checking if AKS [$aksClusterName] actually exists in the [$aksResourceGroupName] resource group..."

az aks show \
  --name $aksClusterName \
  --resource-group $aksResourceGroupName &>/dev/null

if [[ $? != 0 ]]; then
  echo "No AKS [$aksClusterName] actually exists in the [$aksResourceGroupName] resource group"
  echo "Creating AKS cluster [$aksClusterName] in the [$aksResourceGroupName] resource group..."

  # Create the AKS
  az aks create \
    --name $aksClusterName \
    --resource-group $aksResourceGroupName \
    --location $location \
    --subscription $subscriptionId \
    --node-count 2 \
    --enable-oidc-issuer \
    --enable-workload-identity \
    --generate-ssh-keys 1>/dev/null

  if [[ $? == 0 ]]; then
    echo "AKS [$aksClusterName] successfully created in the [$aksResourceGroupName] resource group"
  else
    echo "Failed to create AKS [$aksClusterName] in the [$aksResourceGroupName] resource group"
    exit
  fi

else
  echo "AKS [$aksClusterName] already exists in the [$aksResourceGroupName] resource group"
fi

az aks get-credentials \
  --name $aksClusterName \
  --resource-group $aksResourceGroupName \
  --file $aksKubeConfigPath \
  --overwrite-existing 

export KUBECONFIG=$aksKubeConfigPath