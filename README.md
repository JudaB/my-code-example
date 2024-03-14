# Home Assignment README

## Description

This repository contains the home assignment "py-word-counter" 
it utilize to show practical understanding for the following concerpts python, kubernets,helm, bash, gitops, argo

The assignment goal is to use Python code inside Docker that will run as a REST API and return the most common words in txt files. During the development process, I utilized k3d to set up a Kubernetes cluster. In order to adopt a GitOps approach, I added ArgoCD to deploy the application chart in the Kubernetes cluster.

Then, I used an existing chart I maintain and added the "py-word-counter". Below is the structure of the values:

```

pyWordCounter:
  enabled: true
  image: judab/py-word-counter:240313-14.19
  ingress:
    enabled: true
    host: "py-word-counter.local" # Default host value
``` 
Once I had script that bring up the Kubernetes cluster and ArgoCD  I started with the Python code.

I design it where the txt-files are loaded from /txt-files/*.txt into a collection scan for the most common words
and prints the result. this way  /txt-files/ can be replace with different volume in the future
here is an example of quries,  you can ask for 2 common words

```
curl http://py-word-counter.local:8082/most_common_words/2
{"most_common_words":[["hello",5],["world",2]]}
```
i added health check for kubernetes 
```
curl http://py-word-counter.local:8082/health-check
{"status":"OK"}judab@DESKTOP-FF34JD6:~/git/my-code-example/demo$
```
and ingress as well

## Requirements
You will need linux with docker yq k3d , the script take care of the installation tested with 
Amazon Image AMI ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20240207.1) 


## Instructions

```
git clone https://github.com/JudaB/my-code-example.git
cd my-code-example/demo
./install.sh
```
once you the installation finsh you can send the following query
curl http://py-word-counter.local:8082/most_common_words/2
