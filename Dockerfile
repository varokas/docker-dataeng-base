# https://github.com/dagster-io/dagster/blob/58b76cc1774e4144c1f88b25ed2d59ae7e81b87d/python_modules/automation/automation/docker/images/user-code-example/Dockerfile

FROM ubuntu:22.04

# To make sure ubuntu does not ask for timezone region interactively
ENV DEBIAN_FRONTEND=noninteractive 

## Ubuntu Apts
RUN apt update \
    && apt install -y software-properties-common \
    && add-apt-repository ppa:ubuntugis/ppa \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt update \
    && apt-get install -y software-properties-common curl python3.8 python3.8-distutils python3.8-dev \ 
    && apt-get install -y g++ \
    && apt-get install -y gdal-bin libgdal-dev \
    && apt-get install -y libx11-6\
    && apt-get install -y libx11-xcb1\
    && apt-get install -y libxcomposite-dev\
    && apt-get install -y libxcursor-dev\
    && apt-get install -y libxdamage1\
    && rm -rf /var/lib/apt/lists/*

## PIP 
RUN curl https://bootstrap.pypa.io/get-pip.py | python3.8
RUN python3.8 -m pip install poetry==1.3.2

