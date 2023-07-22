#!/bin/bash

# Variables
source ./set-variables.sh

# Check if Azure Container Registry already exists
echo "Checking if ACR [$acrName] actually exists in the [$acrResourceGrougName] resource group..."

az acr show \
  --name $acrName \
  --resource-group $acrResourceGrougName &>/dev/null

if [[ $? != 0 ]]; then
  echo "No ACR [$acrName] actually exists in the [$acrResourceGrougName] resource group"
  echo "Creating ACR [$acrName] in the [$acrResourceGrougName] resource group..."

  # Create the acr
  az acr create \
    --name $acrName \
    --resource-group $acrResourceGrougName \
    --location $location \
    --subscription $subscriptionId \
    --sku Standard 1>/dev/null

  if [[ $? == 0 ]]; then
    echo "ACR [$acrName] successfully created in the [$acrResourceGrougName] resource group"
  else
    echo "Failed to create ACR [$acrName] in the [$acrResourceGrougName] resource group"
    exit
  fi

  az acr update \
    --name $acrName \
    --resource-group $acrResourceGrougName \
    --subscription $subscriptionId \
    --anonymous-pull-enabled 1>/dev/null
else
  echo "ACR [$acrName] already exists in the [$acrResourceGrougName] resource group"
fi
