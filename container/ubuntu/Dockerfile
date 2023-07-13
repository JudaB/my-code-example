# Base image
FROM ubuntu:latest

# Define environment variable
ENV VERSION=1.2.0

# Install required packages
RUN apt-get update \
    && apt-get install -y python3 vim zip unzip

# Copy zip_job.py to /tmp folder
COPY files/zip_job.py /tmp/
ENTRYPOINT entrypoint.sh

