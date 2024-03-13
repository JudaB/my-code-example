# My Code Example Repository

This repository contains examples of code written in various programming languages and frameworks.

## Contents

- `python-word-counter`: A Python script that counts words in text files.
- `javascript-calculator`: A simple calculator implemented in JavaScript.
- `java-helloworld`: A basic "Hello, World!" program written in Java.
- `docker-compose-example`: An example of using Docker Compose to orchestrate a multi-container application.

## Usage

Each directory contains the source code and relevant files for the respective example. Detailed usage instructions can be found within each directory's README file.

things i worked today and yesterday 

1.  bring up k3d  with script
    then install argocd and create argod application yaml
    that will install the app,
    from the chart side,  i created gitpages for the repo so you can access to judab.github.com for readying the chart
    at the end i didnt use the web repo  i am pull the repo itself in the app
    i configure the app to automatic spin

    created container that copy files from txt-files directory into the docker
    create a python file that will move the txt files into collection and return the most common words
    then i took this code into fastapi     and i added health-check page for the kbuernetes create docker image with _coimpile.sh

    i added new templates for deployment and svc in the chart  the deployment for py-counter-deploy i had to fix the chart 

pyWordCounter:
  enabled: true
  image: judab/py-word-counter:240313-14.19
  ingress:
    enabled: true
    host: "py-word-counter.local" # Default host value
