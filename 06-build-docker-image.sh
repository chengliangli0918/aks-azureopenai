#!/bin/bash

# Variables
source ./set-variables.sh

# Build the docker image
docker build -t $imageName:$tag -f Dockerfile .