# Start from the puckel/docker-airflow image
FROM puckel/docker-airflow:1.10.8

# Switch the user to root
USER root

# Update and install sudo
RUN apt-get update && apt-get -y install sudo

# Install docker for python with pip
RUN pip install docker

# Install docker inside the webserver container
RUN curl -sSL https://get.docker.com/ | sh

# Add airflow user to docker group
RUN usermod -aG docker airflow

# Add airflow to sudo and set password to airflow
RUN echo airflow:airflow | chpasswd && adduser airflow sudo

# Switch back to airflow user
USER airflow
