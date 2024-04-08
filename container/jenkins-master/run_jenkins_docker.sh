#!/bin/bash
# Before run this script on the host in order to have the Jenkins Container
# Make sure to edit docker daemon and enable docker api on port 2375
#
docker run   --name jenkins-blueocean   \
	--restart=on-failure   \
        --detach   \
	--network jenkins   \
	--env DOCKER_HOST=tcp://172.31.56.28:2375   \
	--env DOCKER_TLS_VERIFY="" \
        --env DOCKER_CERT_PATH="" \
        --env  DOCKER_TLS_CERTDIR="" \
	--publish 8080:8080   \
	--publish 50000:50000   \
	--volume jenkins-data:/var/jenkins_home   \
	myjenkins-blueocean:2.401.2-1
