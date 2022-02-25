.DEFAULT_GOAL=compile

update:
	docker pull python:3.11.0a5-bullseye
build:
	docker build -t hatchery-bootstrap hatchery-bootstrap
compile:
	docker run -it -v ${PWD}:/root/hostpwd/ hatchery-bootstrap /root/hostpwd/compile.sh /root/hostpwd/py311.conf
