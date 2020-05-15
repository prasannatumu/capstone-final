#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
docker build -t webserver-image:v1 .


# Step 2: 
# List docker images
docker images


# Step 3: 
# Run webserver
docker run -d -p 80:80 webserver-image:v1
