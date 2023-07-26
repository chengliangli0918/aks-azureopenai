#!/bin/bash

# Variables
source ./set-variables.sh

# Check if OpenAI resource group exists
az group show --name $openAiResourceGroupName &>/dev/null
if [[ $? != 0 ]]; then
   az group create \
    --name $openAiResourceGroupName \
    --location $location 1>/dev/null
fi

# Check if Azure OpenAI already exists
echo "Checking if Azure OpenAI '$openAiName' actually exists in the '$openAiResourceGroupName' resource group..."

az cognitiveservices account show \
  --name $openAiName \
  --resource-group $openAiResourceGroupName &>/dev/null

if [[ $? != 0 ]]; then
  echo "No Azure OpenAI '$openAiName' actually exists in the '$openAiResourceGroupName' resource group"
  echo "Creating Azure OpenAI '$openAiName' in the '$openAiResourceGroupName' resource group..."

  # Create Azure OpenAI account
  az cognitiveservices account create \
    -n $openAiName \
    -g $openAiResourceGroupName \
    -l $location \
    --kind OpenAI \
    --sku s0 \
    --custom-domain $openAiName \
    --subscription $subscriptionId \
    1>/dev/null

  if [[ $? == 0 ]]; then
    echo "Azure OpenAI '$openAiName' successfully created in the '$openAiResourceGroupName' resource group"
  else
    echo "Failed to create Azure OpenAI '$openAiName' in the '$openAiResourceGroupName' resource group"
    exit
  fi

  # Create Azure OpenAI account deployment
  az cognitiveservices account deployment create \
    -n $openAiName \
    -g $openAiResourceGroupName \
    --deployment-name $openAiDeployment \
    --model-name $openAiModel \
    --model-format OpenAI \
    --scale-settings-scale-type "Standard" \
    --model-version 0301 1>/dev/null

  if [[ $? == 0 ]]; then
    echo "Deployment $openAiDeployment successfully created for Azure OpenAI '$openAiName' in the '$openAiResourceGroupName' resource group"
  else
    echo "Failed to create Deployment $openAiDeployment for Azure OpenAI '$openAiName' in the '$openAiResourceGroupName' resource group"
    exit
  fi
else
  echo "Azure OpenAI '$openAiName' already exists in the '$openAiResourceGroupName' resource group"
fi
