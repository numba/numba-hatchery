.DEFAULT_GOAL=compile_and_test-pypi-arm64

# The general idea here is to provide a framework for developing cpython minor
# updates support for the Numba stack: llvmlite and Numba. This is achieved by
# virtue of docker containers provided eithe by the Python project or Anaconda
# that contain pre-releases or release candidates. A bootstrapping container
# will be built that contains the three major dependencies:
#
# * cpython
# * LLVM
# * NumPy
#
# The are several variations designated by abbreviations:
#
# * pypi -- use PyPi and Python docker containers
# * aorg -- use Anaconda.org and miniconda docker containers
# * arm64 -- linux-aarch64 architecture
# * amd64 -- linux-x86_64 architecture
#
# Note: you can run this using docker for OSX and use both the arm64 and amd64
# targets on M* series hardware.
#
# A Sample session would look like:
#
# $ make update-pypi-arm64              # pull docker containers
# $ make build-pypi-arm64               # build bootstrapping container
# $ make clone                          # clone sources
# $ make compile_and_test-pypi-arm64    # compile and test stack

# The `update-*` targets will fetch a suitabl Python docker container.

update-pypi-amd64:
	docker pull --platform linux/amd64 python:3.14-rc
update-pypi-arm64:
	docker pull --platform linux/arm64 python:3.14-rc

update-aorg-amd64:
	docker pull --platform linux/amd64 continuumio/miniconda3
update-aorg-arm64:
	docker pull --platform linux/arm64 continuumio/miniconda3

# The `build-*` targets will build a docker container that contains the other two
# major dependencies of the Numba stack: LLVM and Numpy. LLVM will be obtained
# using an injection of the miniconda distriubtion and subsequent installation
# of the `llvmdev` package. Numpy will be either installed as a binary wheel or
# compiled from source.

build-pypi-amd64:
	docker build --no-cache -t hatchery-bootstrap-amd64 hatchery-bootstrap-amd64
build-pypi-arm64:
	docker build --no-cache -t hatchery-bootstrap-arm64 hatchery-bootstrap-arm64

build-aorg-amd64:
	docker build --no-cache -t hatchery-bootstrap-aorg-amd64 hatchery-bootstrap-aorg-amd64
build-aorg-arm64:
	docker build --no-cache -t hatchery-bootstrap-aorg-arm64 hatchery-bootstrap-aorg-arm64

# The `clone command will clone the correct llvmlite and Numba repositories and
# checkout the correct branches. Go read the `clone.sh` and `.conf` files to
# understand what is going on here.

clone:
	rm -rf llvmlite numba
	./clone.sh py314.conf

# The compile-* and the compil_and_test targets do exactly that. Either compile
# llvmlite and Numba or compile and test llvmlite and Numba. They use the
# docker containers built by the `build-*` targets to supply suitable
# dependencies. Using the `.local.conf` configuration files points to local
# clones of the Numba and llvmlite so modifications can be made locally and
# tested within this framework.

compile-pypi-amd64:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-amd64 /root/hostpwd/compile.sh /root/hostpwd/py314.local.conf
compile-pypi-arm64:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-arm64 /root/hostpwd/compile.sh /root/hostpwd/py314.local.conf

compile-aorg-amd64:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-aorg-amd64 /root/hostpwd/compile-aorg.sh /root/hostpwd/py314.local.conf
compile-aorg-arm64:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-aorg-arm64 /root/hostpwd/compile-aorg.sh /root/hostpwd/py314.local.conf

compile_and_test-pypi-amd64:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-amd64 /root/hostpwd/compile.sh /root/hostpwd/py314.local.conf --test
compile_and_test-pypi-arm64:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-arm64 /root/hostpwd/compile.sh /root/hostpwd/py314.local.conf --test

compile_and_test-aorg-amd64:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-aorg-amd64 /root/hostpwd/compile-aorg.sh /root/hostpwd/py314.local.conf --test
compile_and_test-aorg-arm64:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-aorg-arm64 /root/hostpwd/compile-aorg.sh /root/hostpwd/py314.local.conf --test
