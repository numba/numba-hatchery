FROM --platform=linux/amd64 continuumio/miniconda3

RUN apt update
RUN apt install -y curl git make
RUN . /opt/conda/bin/activate && \
    conda create -c numba/label/dev -c ad-testing/label/py312 \
    -y -n buildenv llvmdev python=3.12 numpy gcc_linux-64 gxx_linux-64
