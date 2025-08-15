# https://github.com/dagster-io/dagster/blob/58b76cc1774e4144c1f88b25ed2d59ae7e81b87d/python_modules/automation/automation/docker/images/user-code-example/Dockerfile

# cannot update to 24.04 yet due to no support for ubuntugis
# E: The repository 'https://ppa.launchpadcontent.net/ubuntugis/ppa/ubuntu noble Release' does not have a Release file.
FROM ubuntu:22.04

# To make sure ubuntu does not ask for timezone region interactively
ENV DEBIAN_FRONTEND=noninteractive

# Ubuntu Apts
RUN apt update \
    && apt install -y software-properties-common gnupg ca-certificates curl\
    && add-apt-repository ppa:ubuntugis/ppa \
    && apt update \
    && apt-get install -y python-dev \
    && apt-get install -y tzdata \
    && apt-get install -y zip unzip \
    && apt-get install -y g++ \
    && apt-get install -y gdal-bin libgdal-dev \
    && apt-get install -y libx11-6\
    && apt-get install -y libx11-xcb1\
    && apt-get install -y libxcomposite-dev\
    && apt-get install -y libxcursor-dev\
    && apt-get install -y libxdamage1\
    && rm -rf /var/lib/apt/lists/*

# Timezone set
ENV TZ=Asia/Bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# ## PIP 
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
