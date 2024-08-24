# https://github.com/dagster-io/dagster/blob/58b76cc1774e4144c1f88b25ed2d59ae7e81b87d/python_modules/automation/automation/docker/images/user-code-example/Dockerfile

FROM ubuntu:22.04

# To make sure ubuntu does not ask for timezone region interactively
ENV DEBIAN_FRONTEND=noninteractive 
ENV SPARK_VERSION=3.5.2

## Ubuntu Apts
RUN apt update \
    && apt install -y software-properties-common gnupg ca-certificates curl\
    && add-apt-repository ppa:ubuntugis/ppa \
    && curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list \
    && apt update \
    && apt-get install -y tzdata \
    && apt-get install -y python3-dev \
    && apt-get install -y zip unzip \
    && apt-get install -y g++ \
    && apt-get install -y gdal-bin libgdal-dev \
    && apt-get install -y libx11-6\
    && apt-get install -y libx11-xcb1\
    && apt-get install -y libxcomposite-dev\
    && apt-get install -y libxcursor-dev\
    && apt-get install -y libxdamage1\
    && apt-get install -y zulu17-jdk\
    && rm -rf /var/lib/apt/lists/*

## Timezone set
ENV TZ=Asia/Bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

## PIP 
RUN curl https://bootstrap.pypa.io/get-pip.py | python3
RUN python3 -m pip install poetry==1.3.2
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

## Sparks
RUN curl -L -o spark-$SPARK_VERSION-bin-hadoop3.tgz https://dlcdn.apache.org/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop3.tgz \
    && tar -xf spark-$SPARK_VERSION-bin-hadoop3.tgz \
    && rm spark-$SPARK_VERSION-bin-hadoop3.tgz \
    && mv spark-$SPARK_VERSION-bin-hadoop3/ /opt/spark

ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
