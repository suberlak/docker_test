FROM ubuntu:latest
FROM continuumio/miniconda3
MAINTAINER Chris Suberlak <suberlak@uw.edu>

# Set shell to bash
SHELL ["/bin/bash", "-c"]

# Update apps
RUN apt-get update \
	&& apt-get upgrade -y

# Update conda
RUN conda update -n base -c defaults conda

# Download the github repo
RUN mkdir repo \
       && cd repo \ 
       && git clone https://github.com/suberlak/docker_test.git --depth=1

# Create Python 3.6 conda environment and install requirements
RUN cd repo/docker_test \
       && conda install -c defaults -c conda-forge -c astropy --file requirements.txt python=3.6 --y \ 
       && python -m ipykernel install --user --name docker_test_env --display-name "DOCKER (Py 3.6)" 
