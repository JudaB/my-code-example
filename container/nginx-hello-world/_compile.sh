#!/usr/bin/env bash

# Compilation script
# Will handle the following
#	Docker Build
#	Unitest (Skiped)
#	Upload to DockerHUB
#
IMAGE="judab/nginx-hello-world"
#QUITE_COMPILE=TRUE




docker_build () {
#Build Image
if [ -z ${QUITE_COMPILE} ] ; then 
	docker build -t ${IMAGE}:latest . 
else
	docker build -t ${IMAGE}:latest .  >/dev/null 2>&1
fi

if [[ $? -ne 0 ]] ; then 
    echo "[ERROR]: Docker Build to ${IMAGE}  Failed"
    exit 2
else 
    echo "[INFO]: Docker Build to ${IMAGE} Pass sucessfully"
fi
}




docker_unitest () {
# Unitest
# Not in use
CONTAINER_ID=$(docker run -td docker.io/${IMAGE}:latest)
sleep 10
true
if [[ $? -ne 0 ]] ; then 
    echo "[ERROR]: Docker unitest  to ${IMAGE}  Failed"
    exit 2
else 
    echo "[INFO]: Docker unitest  to ${IMAGE} Pass sucessfully"
fi
}



docker_upload () {
# Will upload the Docker to DockerHub with Tag of date

TAG=`date +"%y%m%d-%H.%M"`
docker tag "${IMAGE}:latest" "${IMAGE}:"$TAG
if [ -z ${QUITE_COMPILE} ] ; then 
	docker push "${IMAGE}:$TAG"
else
	docker push "${IMAGE}:$TAG" > /dev/null 2>&1
fi

if [[ $? -ne 0 ]] ; then 
    echo "[ERROR]: Docker Push Failed"
    exit 2
else 
    echo "[INFO]: Docker Push ${IMAGE}:${TAG} Pass sucessfully"
fi
}



# Main
docker_build
##docker_unitest
docker_upload


