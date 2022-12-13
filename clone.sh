#!/bin/sh
set -x

# Source the configuration file
. $1

# Clone the repos
git clone $MY_LLVMLITE_URL
pushd llvmlite
git checkout MY_LLVMLITE_COMMIT
popd

git clone $MY_NUMBA_URL
pushd numba
git checkout $MY_NUMBA_COMMIT 
popd
