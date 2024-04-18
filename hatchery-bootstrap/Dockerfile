FROM --platform=linux/amd64 python:3.13.0a6-bullseye

RUN curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh --output  ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p /opt/miniconda
RUN . /opt/miniconda/bin/activate && \
    conda create -c numba/label/manylinux2014 -y -n buildenv llvmdev && \
    conda activate buildenv
RUN python3.13 -m pip install --pre numpy==1.26.3
