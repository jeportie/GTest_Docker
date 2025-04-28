# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jeportie <jeportie@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/28 14:54:38 by jeportie          #+#    #+#              #
#    Updated: 2025/04/28 15:18:25 by jeportie         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
	  valgrind \
      git \
      ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Google Test Build and Install
RUN cd /usr/src/gtest && \
    cmake . && \
    make && \
    cp lib/*.a /usr/lib/ && \
    ldconfig

WORKDIR /project

# Copy only the build logic (CMakeLists + entrypoint)
COPY CMakeLists.txt /project/CMakeLists.txt
COPY entrypoint.sh  /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Declare runtime volumes (mounted at 'docker run')
VOLUME ["/project/src", "/project/test", "/project/build"]

# Always run our build/test script on container start
ENTRYPOINT ["entrypoint.sh"]
