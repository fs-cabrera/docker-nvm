# Base image
FROM debian:latest

# Image meta
MAINTAINER Ferdinand Cabrera <ferdinand.s.cabrera@gmail.com>

# Install pre requisites
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    ca-certificates \
    libssl-dev \
    python \
    rsync \
    software-properties-common \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set NVM environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 4.5.0

# Install NVM
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install node

# Expose path to Node and Node modules
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH