##########################################################
#	Dockerfile
#
#	This docker image is based on the owasp/zap2docker-stable image with some tweaks.
#
#	1. Include miniconda2 (a data analysis-oriented build of python.)
#	2. Include the ELK stack for full-text search and log management.
##########################################################
FROM	owasp/zap2docker-stable
Maintainer	Donald Raikes <dockerdon60@gmail.com>

USER	root
##	Update the system:
RUN	apt-get update -y --fix-missing && \
	apt-get upgrade -y && \
	apt-get install -y python-software-properties software-properties-common apt-transport-https

## 	Install miniconda2
RUN	curl -LOk https://repo.continuum.io/miniconda/Miniconda2-4.3.21-Linux-x86_64.sh && \
	/bin/bash Miniconda2-4.3.21-Linux-x86_64.sh -b -p /opt/conda2 && \
	echo "export PATH=/opt/conda2/bin:$PATH" > /etc/profile.d/myenv.sh 

ENV	PATH=/opt/conda2/bin:$PATH
RUN	conda upgrade --all && \
	pip install elasticsearch python-owasp-zap-v2.4 request selenium xvfbwrapper 

##	Install the elastic stack:
RUN	wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - 
RUN	echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list  && \
	apt-get -y update  && \
	apt-get install -y elasticsearch kibana logstash
#USER	zap
#WORKDIR	/zap
