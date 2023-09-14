.DEFAULT_GOAL=compile

update:
	docker pull --platform linux/amd64 python:3.12.0rc1-bullseye
update-aorg:
	docker pull --platform linux/amd64 ubuntu:latest
build:
	docker build --no-cache -t hatchery-bootstrap hatchery-bootstrap
build-aorg:
	docker build --no-cache -t hatchery-bootstrap-aorg hatchery-bootstrap-aorg
clone:
	rm -rf llvmlite numba
	./clone.sh py312.conf
compile:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap /root/hostpwd/compile.sh /root/hostpwd/py312.local.conf
compile-aorg:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-aorg /root/hostpwd/compile-aorg.sh /root/hostpwd/py312.local.conf
compile_and_test:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap /root/hostpwd/compile_and_test.sh /root/hostpwd/py312.local.conf
compile_and_test-aorg:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap-aorg /root/hostpwd/compile_and_test-aorg.sh /root/hostpwd/py312.local.conf
