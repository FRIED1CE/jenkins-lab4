#!/bin/bash

# Remove all containers
docker rm -vf $(docker ps -a -q)

# Remove all images
docker rmi -f $(docker images -a -q)

# Remove all build cache
docker builder prune --all --force

# Remove all unused networks
docker network prune -f

# Remove all unused volumes
docker volume prune -f
