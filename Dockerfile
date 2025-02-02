# syntax = docker/dockerfile:experimental
FROM ubuntu:20.04
WORKDIR /app

ARG DEBIAN_FRONTEND=noninteractive

# Install base packages (like Python and pip)
RUN apt update && apt install -y curl zip git lsb-release software-properties-common apt-transport-https vim wget python3 python3-pip
RUN python3 -m pip install --upgrade pip==20.3.4

# # Install TensorFlow (separate script as this requires a different command on M1 Macs)
# COPY dependencies/install_tensorflow.sh install_tensorflow.sh
# RUN /bin/bash install_tensorflow.sh && \
#     rm install_tensorflow.sh

# Install CMake (separate script as this requires a different command on M1 Macs)
# COPY dependencies/install_cmake.sh install_cmake.sh
# RUN /bin/bash install_cmake.sh && \
#     rm install_cmake.sh
COPY ./install_tensorflow.sh /
RUN chmod +x /install_tensorflow.sh
# RUN /install_tensorflow.sh

COPY ./install_cmake.sh /
RUN chmod +x /install_cmake.sh

RUN apt update && apt install -y protobuf-compiler

# Copy Python requirements in and install them
COPY requirements.txt ./
RUN pip3 install --no-use-pep517 -r requirements.txt

# Copy the rest of your training scripts in
COPY . ./

# And tell us where to run the pipeline
ENTRYPOINT ["python3", "-u", "train.py"]
