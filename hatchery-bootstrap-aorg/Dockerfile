FROM --platform=linux/amd64 ubuntu:latest

RUN apt update
RUN apt install -y curl git make
RUN curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh --output  ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p /opt/miniconda
RUN . /opt/miniconda/bin/activate && \
    conda create -c numba/label/manylinux2014 -c ad-testing/label/py312 \
    -y -n buildenv llvmdev python=3.12 numpy gcc_linux-64 gxx_linux-64
