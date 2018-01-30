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

# Install packages required to install Pupil Capture.
RUN apt-get update && \
	apt-get -y install unzip

RUN wget https://github.com/pupil-labs/pupil/releases/download/v1.2/pupil_v1.2-7_usb_fix_linux_x64.zip && \
	unzip pupil_v1.2-7_usb_fix_linux_x64.zip

RUN apt-get -y install udev
RUN dpkg -i pupil_capture_linux_os_x64_v1.2-7.deb

# I abandon, there are lots of missing deps.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ubuntu-desktop

# Set default command
CMD ["/bin/bash"]
