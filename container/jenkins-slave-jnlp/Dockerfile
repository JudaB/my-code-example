FROM jenkins/jnlp-agent-docker:latest
USER root
ARG TERRAFORM_VERSION=1.1.9
ARG KUBE_VERSION=v1.20.15
ARG HELM_VERSION=v3.8.1
#install kubernetes
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl
#install helm
RUN curl -LO https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -zvxf ./helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && mv ./linux-amd64/helm /usr/bin/helm
#install terraform
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip  \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin
#Docker Experimental
RUN mkdir -p /root/.docker && echo '{"experimental": "enabled"}' > /root/.docker/config.json
ENV DOCKER_CLI_EXPERIMENTAL=enabled
RUN HELM_HOME=/home/jenkins/.helm
# My Utils
RUN apk update && apk add coreutils jq python3 py-pip sed ansible python3-dev libffi-dev openssl-dev gcc libc-dev make && pip install --upgrade pip
RUN pip3 install jinja2 pyyaml datetime requests awscli docker-compose && \
    ln -sf  /usr/bin/docker-compose /usr/local/bin/docker-compose
RUN pip3 install pyyaml --upgrade --ignore-installed
#Disable HostKey checking for servers
RUN mkdir /root/.ssh; touch /root/.ssh/config; echo -e '{"Host *\nStrictHostKeyChecking no\n"}' >> /root/.ssh/config

ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1
USER jenkins
