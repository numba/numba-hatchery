.DEFAULT_GOAL=compile

update:
	docker pull quay.io/pypa/manylinux2014_x86_64
compile:
	docker run -it -v ${PWD}:/root/hostpwd/ quay.io/pypa/manylinux2014_x86_64 /root/hostpwd/compile.sh python3.10 exp/3.10+new_with_detection
