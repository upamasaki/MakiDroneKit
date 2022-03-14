# 使用するubuntuのバージョンを指定
FROM ubuntu:18.04

# 使うコマンドをインストール
RUN \
    apt update && \
    apt -y upgrade && \
    apt install -y build-essential && \
    apt install -y software-properties-common && \
    apt install -y curl git man unzip vim wget sudo git

RUN git clone https://github.com/ArduPilot/ardupilot
RUN cd ardupilot && git submodule update --init --recursive

# ユーザーを作成
ARG DOCKER_UID=1000
ARG DOCKER_USER=docker
ARG DOCKER_PASSWORD=docker
RUN useradd -m --uid ${DOCKER_UID} --groups sudo ${DOCKER_USER} \
  && echo ${DOCKER_USER}:${DOCKER_PASSWORD} | chpasswd

# 作成したユーザーに切り替える
USER ${DOCKER_USER}

RUN  /ardupilot/Tools/environment_install/install-prereqs-ubuntu.sh -y
RUN source ~/.profile