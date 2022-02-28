#!/bin/sh
set -x

# Source the configuration file
. $1

# Clone the repos
git clone -b $MY_LLVMLITE_COMMIT $MY_LLVMLITE_URL
git clone -b $MY_NUMBA_COMMIT $MY_NUMBA_URL
