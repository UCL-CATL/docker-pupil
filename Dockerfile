FROM ubuntu:18.04

MAINTAINER Sébastien Wilmet

WORKDIR /root/

# Have a more comfortable command-line environment.
RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install \
		aptitude \
		ubuntu-standard

# There is apparently no metapackage to install a minimal desktop system. So
# install the whole default Ubuntu desktop, to be sure that all dependencies
# are installed.
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -y install ubuntu-desktop

# Install additional packages required to install Pupil Capture.
RUN apt-get update && \
	apt-get -y install unzip

RUN wget https://github.com/pupil-labs/pupil/releases/download/v1.9/pupil_v1.9-7-gdf51687_linux_x64.zip && \
	unzip pupil_v1.9-7-gdf51687_linux_x64.zip && \
	dpkg -i pupil_v1.9-7-gdf51687_linux_x64/pupil_capture_linux_os_x64_v1.9-7-gdf51687.deb

# Set default command
CMD ["/bin/bash"]
