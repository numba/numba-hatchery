.DEFAULT_GOAL=compile

update:
	docker pull quay.io/pypa/manylinux2014_x86_64
compile:
	docker run -it -v ${PWD}:/root/hostpwd/ quay.io/pypa/manylinux2014_x86_64 /root/hostpwd/compile.sh 334c000d5a6d19133e3ce3b7a2c847cd682f4ebf
