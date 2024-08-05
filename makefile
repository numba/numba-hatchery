.DEFAULT_GOAL=compile-pypi

update-pypi:
	docker pull --platform linux/amd64 python:3.13.0rc1-bullseye
update-aorg:
	docker pull --platform linux/amd64 continuumio/miniconda3
build-pypi:
	docker build --no-cache -t hatchery-bootstrap hatchery-bootstrap
build-aorg:
	docker build --no-cache -t hatchery-bootstrap-aorg hatchery-bootstrap-aorg
clone:
	rm -rf llvmlite numba
	./clone.sh py313.conf
compile-pypi:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap /root/hostpwd/compile-pypi.sh /root/hostpwd/py313.local.conf
compile-aorg:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-aorg /root/hostpwd/compile-aorg.sh /root/hostpwd/py313.local.conf
compile_and_test-pypi:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap /root/hostpwd/compile_and_test-pypi.sh /root/hostpwd/py313.local.conf
compile_and_test-aorg:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-aorg /root/hostpwd/compile_and_test-aorg.sh /root/hostpwd/py313.local.conf
