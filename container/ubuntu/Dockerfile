# Base image
FROM ubuntu:latest

# Define environment variable
ENV VERSION=1.2.0

# Install required packages
RUN apt-get update \
    && apt-get install -y python3 vim zip unzip \
    && apt-get install -y --no-install-recommends openjdk-17-jdk-headless
# Copy zip_job.py to /tmp folder
COPY files/zip_job.py /tmp/
#ENTRYPOINT entrypoint.sh



# Install required packages
RUN apt-get update && apt-get install -y openssh-server

# Create a Jenkins user
RUN useradd -m -d /home/jenkins -s /bin/bash jenkins

# Set up SSH
RUN mkdir /var/run/sshd

# Set the Jenkins user's password
RUN echo 'jenkins:jenkins' | chpasswd

# Enable password authentication and root login
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start the SSH server
CMD ["/usr/sbin/sshd", "-D"]
