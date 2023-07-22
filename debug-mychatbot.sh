#!/bin/bash

# Variables
source ./set-variables.sh

# Run the docker container
docker run -it \
  --rm \
  -p 8080:8080 \
  -e TEMPERATURE=$temperature \
  -e AZURE_OPENAI_BASE=$openAiBase \
  -e AZURE_OPENAI_KEY="118cb1fff45d4f4a877740b2847e78df" \
  -e AZURE_OPENAI_MODEL=$openAiModel \
  -e AZURE_OPENAI_DEPLOYMENT=$openAiDeployment \
  --name $containerName \
  $imageName:$tag
