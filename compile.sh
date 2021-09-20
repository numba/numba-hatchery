#!/bin/sh
set -x
if [ -n "$1" ] ; then
    LLVMLITE_COMMIT="$1"
else
    LLVMLITE_COMMIT="master"
fi
echo LLVMLITE_COMMIT=$LLVMLITE_COMMIT
if [ -n "$2" ] ; then
    NUMBA_COMMIT="$2"
else
    NUMBA_COMMIT="master"
fi
shift
PYTHON="python3.10"
echo NUMBA_COMMIT=$NUMBA_COMMIT
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh --output  ~/miniconda.sh
bash ~/miniconda.sh -b -p /opt/miniconda
source /opt/miniconda/bin/activate
conda create -c numba/label/manylinux2014 -y -n buildenv llvmdev
conda activate buildenv
git clone https://github.com/esc/llvmlite.git
cd llvmlite
git checkout $LLVMLITE_COMMIT
LLVM_CONFIG=/opt/miniconda/envs/buildenv/bin/llvm-config $PYTHON setup.py install
$PYTHON -m llvmlite.tests
cd ..
$PYTHON -m pip install numpy==1.20
git clone https://github.com/esc/numba.git
cd numba
git checkout $NUMBA_COMMIT
$PYTHON setup.py build_ext -i && $PYTHON setup.py develop
cd ..
$PYTHON -m numba.runtests
exec bash

