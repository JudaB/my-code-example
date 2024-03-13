#!/usr/bin/env bash

# Compilation script
#	Docker Build
#	Unitest
#	Upload
#
IMAGE="judab/py-word-counter"

docker_build () {
	docker build -t ${IMAGE}:latest . 
if [[ $? -ne 0 ]] ; then 
    echo "[ERROR]: Docker Build to ${IMAGE}  Failed"
    exit 2
else 
    echo "[INFO]: Docker Build to ${IMAGE} finished sucessfully"
fi
}

docker_upload () {
TAG=`date +"%y%m%d-%H.%M"`
docker tag "${IMAGE}:latest" "${IMAGE}:"$TAG
docker push "${IMAGE}:$TAG"
if [[ $? -ne 0 ]] ; then 
    echo "[ERROR]: Docker Push Failed"
    exit 2
else 
    echo "[INFO]: Docker Push ${IMAGE}:${TAG} Pass sucessfully"
fi
}



# Main
docker_build
docker_upload


