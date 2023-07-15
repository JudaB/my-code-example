# Base image
FROM ubuntu:latest

# Define environment variable
ENV VERSION=1.2.0

# Install required packages
RUN apt-get update \
    && apt-get install -y python3 vim zip unzip \
    && apt-get install -y --no-install-recommends openjdk-17-jdk-headless

# handle SSH
RUN apt-get update && apt-get install -y openssh-server
RUN useradd -m -d /home/jenkins -s /bin/bash jenkins
RUN mkdir /var/run/sshd
RUN echo 'jenkins:jenkins' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

COPY files/zip_job.py /tmp/
COPY files/entrypoint.sh /
COPY files/cmd.sh /


# Start the SSH server
#CMD ["/usr/sbin/sshd", "-D"]
ENTRYPOINT [ "/entrypoint.sh" ]
#CMD ["/cmd.sh"]
