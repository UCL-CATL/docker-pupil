FROM ubuntu:17.10

MAINTAINER Sébastien Wilmet

WORKDIR /root/

RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install \
		aptitude \
		ubuntu-standard

# There is apparently no metapackage to install a minimal desktop system. So
# install a small GUI app instead.
RUN apt-get update && \
	apt-get -y install leafpad

# Set default command
CMD ["/bin/bash"]
