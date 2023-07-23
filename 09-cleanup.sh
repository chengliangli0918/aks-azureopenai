#!/bin/bash

# Variables
source ./set-variables.sh

echo "Delete and purge Azure OpenAI [$openAiName] in the [$openAiResourceGroupName] resource group..."

az cognitiveservices account delete -n $openAiName -g $openAiResourceGroupName
az cognitiveservices account purge -n $openAiName -g $openAiResourceGroupName -l $location

echo "Delete other Azure resources in other resource groups..."
az group delete -g $openAiResourceGroupName -y --no-wait
az group delete -g $acrResourceGrougName -y --no-wait
az group delete -g $aksResourceGroupName -y --no-wait
