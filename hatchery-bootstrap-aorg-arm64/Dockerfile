FROM --platform=linux/arm64 continuumio/miniconda3

RUN apt update && apt install -y cmake
RUN . /opt/conda/bin/activate && \
    conda create -c numba/label/dev -c ad-testing/label/py314 -c defaults \
    -y -n buildenv llvmdev=20 python=3.14 numpy \
    gcc_linux-aarch64 gxx_linux-aarch64 setuptools
