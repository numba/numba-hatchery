FROM --platform=linux/arm64 python:3.14-rc

RUN apt update && apt install -y cmake
RUN curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh --output  ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p /opt/miniconda
RUN . /opt/miniconda/bin/activate && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main  && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r && \
    conda create -c numba/label/llvm20-wheels -y -n buildenv llvmdev=20 && \
    conda activate buildenv
RUN python3.14 -m pip install --pre numpy setuptools
