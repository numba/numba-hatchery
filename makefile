.DEFAULT_GOAL=compile

update:
	docker pull python:3.11.0rc1-bullseye
build:
	docker build -t hatchery-bootstrap hatchery-bootstrap
clone:
	./clone.sh py311.conf
compile:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap /root/hostpwd/compile.sh /root/hostpwd/py311.local.conf
