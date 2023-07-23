---
page_type: sample
languages:
- azurecli
- bash
- python
- yaml
- json
products:
- azure
- azure-openai
- azure-resource-manager
- azure-kubernetes-service
- azure-container-registry
- azure-virtual-network
- azure-virtual-machines
name:  How to create an AKS cluster and run chatbot application to access Azure OpenAI using Workload Identity
description: This sample shows how to install an AKS cluster and run chatbot application to access Azure OpenAI using Workload Identity.
---

# How to deploy and run an Azure OpenAI ChatGPT application on AKS

This sample shows how to deploy an [Azure Kubernetes Service(AKS)](https://docs.microsoft.com/en-us/azure/aks/intro-kubernetes) cluster and [Azure OpenAI Service](https://learn.microsoft.com/en-us/azure/cognitive-services/openai/overview) using Azure CLI (https://learn.microsoft.com/en-us/cli/azure/) and how to deploy a Python chatbot that authenticates against Azure OpenAI using [Azure AD workload identity](https://learn.microsoft.com/en-us/azure/aks/workload-identity-overview) and calls the [Chat Completion API](https://platform.openai.com/docs/api-reference/chat) of a [ChatGPT model](https://learn.microsoft.com/en-us/azure/cognitive-services/openai/concepts/models#chatgpt-gpt-35-turbo).

A chatbot is an application that simulates human-like conversations with users via chat. Its key task is to answer user questions with instant messages. [Azure Kubernetes Service(AKS)](https://docs.microsoft.com/en-us/azure/aks/intro-kubernetes) cluster communicates with [Azure OpenAI Service](https://learn.microsoft.com/en-us/azure/cognitive-services/openai/overview).

![Chatbot backed AKS and Azure OpenAI](/images/chatbotaksopenai.png)


For more information on Azure OpenAI Service, see the following articles:

- [Azure OpenAI Service models](https://learn.microsoft.com/en-us/azure/cognitive-services/openai/concepts/models)
- [What is Azure OpenAI Service?](https://learn.microsoft.com/en-us/azure/cognitive-services/openai/overview)
