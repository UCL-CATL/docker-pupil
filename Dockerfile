# https://github.com/UCL-CATL/cosy-docker-layer
FROM ucl-cosy/cosy-docker-layer:25

MAINTAINER Sébastien Wilmet

WORKDIR /root/

RUN dnf -y builddep libjpeg-turbo

# Install libjpeg-turbo from sources to use the --with-pic flag.
RUN curl -o libjpeg-turbo.tar.gz -L "http://sourceforge.net/projects/libjpeg-turbo/files/1.4.2/libjpeg-turbo-1.4.2.tar.gz/download" && \
	tar xf libjpeg-turbo.tar.gz && \
	cd libjpeg-turbo-1.4.2 && \
	./configure --with-pic && \
	make install

# Set default command
CMD ["/usr/bin/bash"]
