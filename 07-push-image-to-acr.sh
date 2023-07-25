#!/bin/bash

# Variables
source ./set-variables.sh

# Login to ACR
az acr login --name $acrName 

loginServer=$(az acr show --name $acrName -g $acrResourceGrougName --query loginServer --output tsv)

docker tag ${imageName,,}:$tag $loginServer/${imageName,,}:$tag

docker push $loginServer/${imageName,,}:$tag