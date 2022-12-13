#!/bin/sh
set -x

# Source the configuration file
. $1

# Clone the repos
git clone $MY_LLVMLITE_URL
cd llvmlite
git checkout $MY_LLVMLITE_COMMIT
cd ..

git clone $MY_NUMBA_URL
cd numba
git checkout $MY_NUMBA_COMMIT 
cd ..
