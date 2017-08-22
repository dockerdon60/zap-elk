##########################################################
#	Dockerfile
#
#	This docker image is based on the owasp/zap2docker-stable image with some tweaks.
##########################################################
FROM	owasp/zap2docker-stable
Maintainer	Donald Raikes <dockerdon60@gmail.com>

USER	root
##	Update the system:
RUN	apt-get update -y --fix-missing && \
	apt-get upgrade -y

USER	zap
WORKDIR	/zap
