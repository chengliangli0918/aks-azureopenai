#!/bin/bash

# Variables
source ./set-variables.sh

# Login to ACR
az acr login --name $acrName 

loginServer=$(az acr show --name $acrName --query loginServer --output tsv)

# Tag the local image with the loginServer of ACR
docker tag ${imageName,,}:$tag $loginServer/${imageName,,}:$tag

# Push latest container image to ACR
docker push $loginServer/${imageName,,}:$tag