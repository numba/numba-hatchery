FROM --platform=linux/amd64 python:3.12.0rc1-bullseye

RUN curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh --output  ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p /opt/miniconda
RUN . /opt/miniconda/bin/activate && \
    conda create -c numba/label/manylinux2014 -y -n buildenv llvmdev && \
    conda activate buildenv
RUN python3.12 -m pip install --pre numpy
