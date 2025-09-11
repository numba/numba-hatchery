#!/bin/bash
set -xe

# Usage function
usage() {
    echo "Usage: $0 <config_file> [options]"
    echo "Options:"
    echo "  --test        Run tests after building"
    echo "Example: $0 config.sh --test"
    exit 1
}

# Check for at least one argument
if [ $# -lt 1 ]; then
    usage
fi

# Parse arguments
CONFIG_FILE=$1
shift

# Default options
RUN_TESTS=false

# Parse optional arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --test)
            RUN_TESTS=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Source the configuration file
. "$CONFIG_FILE"


# Activate environment
. /opt/conda/bin/activate
conda activate buildenv

# Build llvmlite
git clone $MY_LLVMLITE_URL
cd llvmlite
git checkout $MY_LLVMLITE_COMMIT
export CMAKE_PREFIX_PATH=/opt/miniconda/envs/buildenv/lib/cmake/llvm/

$MY_PYTHON setup.py install

# Run llvmlite tests if requested
if [ "$RUN_TESTS" = true ]; then
    cd $HOME
    $MY_PYTHON -m llvmlite.tests
    cd -
fi

cd ..

# Build numba
git clone $MY_NUMBA_URL
cd numba
git checkout $MY_NUMBA_COMMIT

# Install numba using development mode
$MY_PYTHON setup.py build_ext -i && $MY_PYTHON setup.py develop --no-deps

cd ..

# Run numba tests if requested
if [ "$RUN_TESTS" = true ]; then
    cd $HOME
    $MY_PYTHON -m numba.runtests -m 10
    cd -
fi

echo "alias update_numba='cd /numba && git fetch --all && git reset --hard @{u} && python setup.py install && cd -'" >> ~/.bashrc

exec bash
