# numba-hatchery

Full-stack build for llvmdev --> llvmlite --> Numba.

# About

This is a collection of scripts and make files to compile Numba and llvmlite
within a Python docker container with minimal dependencies. It's primary
purpose is to test and evaluate the compatibility of Numba with new
pre-releases of Python minor versions.

# Commands

The command:

```
make update
```

Will pull the correct Python docker image.

The command:

```
make build
```

Will prepare a docker-container specified in `hatchery-bootstrap/` that
is based on the vanilla Python container but additionally contains an
installation of `llvmdev` (compiled for use with Numba) in a miniconda and a
`pip`  installed Numpy, either compiled from source or via a wheel, if such a
wheel is available.

The command:

```
make clone
```

Will clone the correct repositories and references and place them such that
they can be mounted into the docker container.

```
make compile
```

Will launch the compilation of `llvmlite`, followed by`Numba` in
the pre-built docker container.

Finally, the command:

```
make compile_and_test
```

Will launch the compilation and testing of `llvmlite`, followed by`Numba` in
the pre-built docker container.
