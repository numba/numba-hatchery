# numba-hatchery

Full-stack build for llvmdev --> llvmlite --> Numba.

# About

This is a collection of scripts and make files to compile Numba and llvmlite
within a Python docker container with minimal dependencies. It's primary
purpose is to test and evaluate the compatibility of Numba with new
pre-releases of Python minor versions.

The process can run either using the docker containers provided from Python
developers directly (pypi) or by using packages from anaconda.org (aorg). Use
the correct make targets to trigger.

For more information about the current capabilities of this framework please
see the comments in the `makefile`.
