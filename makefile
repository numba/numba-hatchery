.DEFAULT_GOAL=compile

update:
	docker pull --platform linux/amd64 python:3.12.0rc1-bullseye
build:
	docker build --no-cache -t hatchery-bootstrap hatchery-bootstrap
clone:
	./clone.sh py312.conf
compile:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap /root/hostpwd/compile.sh /root/hostpwd/py312.conf
compile_and_test:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap /root/hostpwd/compile_and_test.sh /root/hostpwd/py312.conf
