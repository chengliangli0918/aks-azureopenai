#!/bin/bash

# Variables
source ./set-variables.sh

# Debug the mychatbot on dev machine before on k8s/AKS
docker run -it \
  --rm \
  -p 8080:8080 \
  -e TEMPERATURE=$temperature \
  -e AZURE_OPENAI_BASE=$openAiBase \
  -e AZURE_OPENAI_KEY="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" \
  -e AZURE_OPENAI_MODEL=$openAiModel \
  -e AZURE_OPENAI_DEPLOYMENT=$openAiDeployment \
  --name $containerName \
  $imageName:$tag
