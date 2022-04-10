# https://github.com/dagster-io/dagster/blob/58b76cc1774e4144c1f88b25ed2d59ae7e81b87d/python_modules/automation/automation/docker/images/user-code-example/Dockerfile

FROM ubuntu:20.04

# To make sure ubuntu does not ask for timezone region interactively
ENV DEBIAN_FRONTEND=noninteractive 

## Ubuntu Apts
RUN apt update \
    && apt install -y software-properties-common \
    && add-apt-repository ppa:ubuntugis/ppa \
    && apt update \
    && apt install -y software-properties-common python3 python3-pip # python 3.8 \ 
    && apt install -y gdal-bin libgdal-dev \
    && rm -rf /var/lib/apt/lists/*

## PIP 
RUN python3 -m pip install --upgrade pip \
    && python3 -m pip install poetry

