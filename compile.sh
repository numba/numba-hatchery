#!/bin/sh
set -x

. $1
git clone https://github.com/esc/llvmlite.git
cd llvmlite
git checkout $MY_LLVMLITE_COMMIT
export LLVM_CONFIG=/opt/miniconda/envs/buildenv/bin/llvm-config
$MY_PYTHON setup.py install
$MY_PYTHON -m llvmlite.tests
cd ..
$MY_PYTHON -m pip install numpy
git clone https://github.com/esc/numba.git
cd numba
git checkout $MY_NUMBA_COMMIT
$MY_PYTHON setup.py build_ext -i && $MY_PYTHON setup.py develop
cd ..
#$PYTHON -m numba.runtests
exec bash

