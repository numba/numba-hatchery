#!/bin/sh
set -x

. $1
git clone https://github.com/esc/llvmlite.git
cd llvmlite
git checkout $MY_LLVMLITE_COMMIT
export LLVM_CONFIG=/opt/miniconda/envs/buildenv/bin/llvm-config
# When building on the python:3.11.0a5-bullseye image using the llvmdev that was
# compiled on a quay.io/pypa/manylinux2014_x86_64 image, we need to clamp the
# C++ ABI version to 0.
CXXFLAGS="$CXXFLAGS -D_GLIBCXX_USE_CXX11_ABI=0" $MY_PYTHON setup.py install
$MY_PYTHON -m llvmlite.tests
cd ..
git clone https://github.com/esc/numba.git
cd numba
git checkout $MY_NUMBA_COMMIT
$MY_PYTHON setup.py build_ext -i && $MY_PYTHON setup.py develop
cd ..
$MY_PYTHON -m numba.runtests -m 6
exec bash
