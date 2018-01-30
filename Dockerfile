FROM ubuntu:17.10

MAINTAINER Sébastien Wilmet

WORKDIR /root/

RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install \
		aptitude \
		ubuntu-standard

# Set default command
CMD ["/bin/bash"]
