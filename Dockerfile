FROM nvidia/cuda:12.1.0-base-ubuntu22.04
FROM node:lts-bullseye-slim
# FROM python:latest

ENV TZ Asia/Tokyo
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update && apt-get upgrade -y \
    curl \
    file \
    wget \
    git \
    sudo

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential libbz2-dev libdb-dev \
    libreadline-dev libffi-dev libgdbm-dev liblzma-dev \
    libncursesw5-dev libsqlite3-dev libssl-dev \
    zlib1g-dev uuid-dev \
 && rm -rf /var/lib/apt/lists/*

#任意バージョンのpython install
RUN wget --no-check-certificate https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz \
    && tar -xf Python-3.10.0.tgz \
    && cd Python-3.10.0 \
    && ./configure --enable-optimizations\
    && make \
    && make install

#サイズ削減のため不要なものは削除
RUN apt-get autoremove -y

RUN sudo update-alternatives --install /usr/bin/python python /usr/local/bin/python3.10 1

RUN python -m pip install --upgrade pip
RUN pip install --upgrade setuptools

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt \
    && rm -rf ~/.cache/pip

RUN pip install --no-cache-dir \
    jupyterlab
    # ipywidgets \
    # jupyterlab-git \
    # jupyterlab_code_formatter \
    # lckr-jupyterlab-variableinspector \
    # jupyter_tensorboard

# RUN jupyter contrib nbextension install --user
# RUN jupyter nbextensions_configurator enable --user

# Mecabのインストール
RUN apt-get update && apt-get install -y \
    mecab \
    libmecab-dev \
    mecab-ipadic-utf8 \
 && rm -rf /var/lib/apt/lists/*
RUN cp /etc/mecabrc /usr/local/etc/

RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git \
    && cd mecab-ipadic-neologd \
    && ./bin/install-mecab-ipadic-neologd -n -y

# fastTextのインストール
RUN git clone https://github.com/facebookresearch/fastText.git \
    && cd fastText \
    && pip install .

WORKDIR /work

# RUN git clone --recurse-submodules https://github.com/yoheikikuta/bert-japanese