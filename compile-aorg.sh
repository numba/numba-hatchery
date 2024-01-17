#!/bin/bash
set -x

# Source the configuration file
. $1

. /opt/conda/bin/activate
conda activate buildenv

# llvmlite
git clone $MY_LLVMLITE_URL
cd llvmlite
git checkout $MY_LLVMLITE_COMMIT
export LLVM_CONFIG=/opt/conda/envs/buildenv/bin/llvm-config
# When building on the python:3.11.0a5-bullseye image using the llvmdev that was
# compiled on a quay.io/pypa/manylinux2014_x86_64 image, we need to clamp the
# C++ ABI version to 0.
$MY_PYTHON setup.py install
cd ..

# numba
git clone $MY_NUMBA_URL
cd numba
git checkout $MY_NUMBA_COMMIT
$MY_PYTHON -m pip install -e .
cd ..
exec bash
