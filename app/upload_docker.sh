#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
dockerpath=nofsky/udacity-static-capstone

docker build -t webserver-image:v1 .

# Step 2:
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker login --username nofsky
docker image tag webserver-image:v1 $dockerpath

# Step 3:
# Push image to a docker repository
docker push $dockerpath