FROM --platform=linux/arm64 continuumio/miniconda3

RUN apt update && apt install -y cmake
RUN . /opt/conda/bin/activate && \
    conda create -c numba/label/llvm_wheel -c ad-testing/label/py315 -c defaults \
    -y -n buildenv llvmdev=22 python=3.15 numpy \
    gcc_linux-aarch64 gxx_linux-aarch64 setuptools

RUN echo 'conda activate buildenv' >> /root/.bashrc
