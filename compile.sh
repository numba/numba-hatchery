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
conda create -y -n buildenv
conda activate buildenv
/opt/miniconda/bin/conda install -n buildenv /root/hostpwd/llvmdev-11.1.0-manylinux2014.tar.bz2
git clone https://github.com/esc/llvmlite.git
cd llvmlite
git checkout $LLVMLITE_COMMIT
LLVM_CONFIG=/opt/miniconda/bin/llvm-config $PYTHON setup.py bdist_wheel
cd dist
auditwheel --verbose repair *.whl
cd ..
$PYTHON -m llvmlite.tests
exec bash
cd ..
git clone https://github.com/numba/numba.git
cd numba
git checkout $NUMBA_COMMIT
$PYTHON setup.py build_ext -i && $PYTHON setup.py develop --no-deps
$PYTHON -m numba.runtests
exec bash

