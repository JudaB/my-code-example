# Base image
FROM ubuntu:latest

# Define environment variable
ENV VERSION=1.2.0

# Install required packages
RUN apt-get update \
    && apt-get install -y python3 vim zip unzip \
    && apt-get install -y --no-install-recommends openjdk-17-jdk-headless

# handle SSH
# ----
# I add ssh server so it will be comptabile working as jenkins-slave
#       this way i can SSH into the docker and remotely install jenkins client
RUN apt-get update && apt-get install -y openssh-server
RUN useradd -m -d /home/jenkins -s /bin/bash jenkins
RUN mkdir /var/run/sshd
RUN echo 'jenkins:jenkins' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
EXPOSE 22


COPY files/zip_job.py /tmp/
# I added entrypoint another section
# to be comptaible with jenkins Docker plugin
COPY files/entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
