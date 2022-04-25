#!/bin/bash

docker kill $(docker ps -q) # Stop all

docker rm $(docker ps -a -q) # Remove all (running and stopped ones)

# docker rmi $(docker images -q) # Delete all images
