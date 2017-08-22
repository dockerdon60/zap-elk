##########################################################
#	Dockerfile
#
#	This docker image is based on the owasp/zap2docker-stable image with some tweaks.
#
#	1. Include miniconda2 (a data analysis-oriented build of python.)
##########################################################
FROM	owasp/zap2docker-stable
Maintainer	Donald Raikes <dockerdon60@gmail.com>

USER	root
##	Update the system:
RUN	apt-get update -y --fix-missing && \
	apt-get upgrade -y

## 	Install miniconda2
RUN	curl -LOk https://repo.continuum.io/miniconda/Miniconda2-4.3.21-Linux-x86_64.sh && \
	/bin/bash Miniconda2-4.3.21-Linux-x86_64.sh -b -p /opt/conda2 && \
	echo "export PATH=/opt/conda2/bin:$PATH" > /etc/profile.d/myenv.sh 

ENV	PATH=/opt/conda2/bin:$PATH
RUN	conda upgrade --all && \
	pip install elasticsearch python-owasp-zap-v2.4 request selenium xvfbwrapper 

USER	zap
WORKDIR	/zap
