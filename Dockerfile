FROM ubuntu:16.04

MAINTAINER Sébastien Wilmet

WORKDIR /root/

RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install \
		aptitude \
		ubuntu-standard

# Set default command
CMD ["/bin/bash"]
