.DEFAULT_GOAL=compile-pypi

update-pypi-amd64:
	docker pull --platform linux/amd64 python:3.14-rc
update-pypi-arm64:
	docker pull --platform linux/arm64 python:3.14-rc

update-aorg:
	docker pull --platform linux/amd64 continuumio/miniconda3

build-pypi-amd64:
	docker build --no-cache -t hatchery-bootstrap-amd64 hatchery-bootstrap-amd64
build-pypi-arm64:
	docker build --no-cache -t hatchery-bootstrap-arm64 hatchery-bootstrap-arm64

build-aorg:
	docker build --no-cache -t hatchery-bootstrap-aorg hatchery-bootstrap-aorg
clone:
	rm -rf llvmlite numba
	./clone.sh py314.conf

compile-pypi-amd64:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-amd64 /root/hostpwd/compile.sh /root/hostpwd/py314.local.conf
compile-pypi-arm64:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-arm64 /root/hostpwd/compile.sh /root/hostpwd/py314.local.conf

compile-aorg:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-aorg /root/hostpwd/compile-aorg.sh /root/hostpwd/py314.local.conf

compile_and_test-pypi-amd64:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-amd64 /root/hostpwd/compile.sh /root/hostpwd/py314.local.conf --test
compile_and_test-pypi-arm64:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-arm64 /root/hostpwd/compile.sh /root/hostpwd/py314.local.conf --test

compile_and_test-aorg:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-aorg /root/hostpwd/compile_and_test-aorg.sh /root/hostpwd/py314.local.conf
