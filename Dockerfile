# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jeportie <jeportie@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/28 14:54:38 by jeportie          #+#    #+#              #
#    Updated: 2025/04/28 18:14:25 by jeportie         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y locales locales-all python3-venv && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Install all apt dependencies in one go
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
	clang \
	openssh-client \
    cmake \
    make \
    git \
    bear \
    tree \
    ripgrep \
    curl \
    wget \
    npm \
    expect \
    unzip \
    tar \
    p7zip-full \
    zsh \
    libreadline-dev \
    valgrind \
    check \
    lldb \
    libxext-dev \
    libx11-dev \
    libbsd-dev \
    x11-apps \
    xclip \
    python3-pip \
    python3-venv \
    libgtest-dev \
	libgmock-dev \
    lua5.3 \
    lua5.3-dev \
    lua5.1 \
    lua5.1-dev && \
    rm -rf /var/lib/apt/lists/*

# Google Test Build and Install
RUN cd /usr/src/gtest && \
    cmake . && \
    make && \
    cp lib/*.a /usr/lib/ && \
    ldconfig

# Create a Python virtual environment and install : 
# pip, setuptools, pynvim and norminette ************************************* #
RUN python3 -m venv /root/venv && \
    /root/venv/bin/pip install --upgrade pip setuptools pynvim
ENV VIRTUAL_ENV_DISABLE_PROMPT=1
ENV PATH="/root/venv/bin:${PATH}"
RUN /root/venv/bin/pip install norminette

WORKDIR /project
VOLUME [ "/project", "/project/build" ]

ENV GTEST_COLOR=yes

COPY CMakeLists.txt   /project/CMakeLists.txt
COPY entrypoint.sh    /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
