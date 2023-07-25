# Azure Subscription and Tenant
subscriptionId=$(az account show --query id --output tsv)
subscriptionName=$(az account show --query name --output tsv)
tenantId=$(az account show --query tenantId --output tsv)

# ACR
acrName="charliliacr"
acrResourceGrougName="aks-openai"
location="eastus"
attachAcr=false
imageName="mychatbot"
tag="v0"
containerName="mychatbot"
image="$acrName.azurecr.io/$imageName:$tag"
imagePullPolicy="IfNotPresent"

# Workload Identity 
managedIdentityName="myIdentity"
federatedIdentityName="myFedIdentity"

# Azure OpenAI
openAiName="charlili-openai"
openAiResourceGroupName="aks-openai"
openAiType="azure_ad"
openAiBase="https://$openAiName.openai.azure.com/"
openAiModel="gpt-35-turbo"
openAiDeployment="gpt-35-turbo"

# AKS Cluster
aksClusterName="charlili-aks"
aksResourceGroupName="aks-openai"
aksKubeConfigPath="/tmp/kubeconfig"

# Chatbot Application
namespace="default"
serviceAccountName="workload-identity-sa"
deploymentTemplate="deployment.yaml"
serviceTemplate="service.yaml"

# Chatbot argument
title="Chatbot backed by AKS and Azure OpenAI"
temperature="0.5"
