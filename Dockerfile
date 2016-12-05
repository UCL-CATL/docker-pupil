FROM fedora:24
MAINTAINER Sébastien Wilmet

RUN dnf -y upgrade && \
	dnf -y group install "Basic Desktop" && \
	dnf clean all

RUN dnf -y install https://raw.githubusercontent.com/UnitedRPMs/unitedrpms/master/RPM/unitedrpms-24-2.noarch.rpm && \
	rpm --import https://raw.githubusercontent.com/UnitedRPMs/unitedrpms.github.io/master/URPMS-GPG-PUBLICKEY-Fedora-24 && \
	dnf -y upgrade && \
	dnf -y builddep libjpeg-turbo && \
	dnf -y install \
		boost-devel \
		ceres-solver-devel \
		cmake \
		eigen3-devel \
		ffmpeg \
		ffmpeg-devel \
		gcc-c++ \
		gflags-devel \
		git \
		glew-devel \
		glfw-devel \
		glog-devel \
		libusb-devel \
		mesa-libGLU-devel \
		nasm \
		opencv-devel \
		opencv-python \
		python2-pyopengl \
		python2-scipy \
		python-devel \
		redhat-rpm-config && \
	dnf clean all

WORKDIR /root/

# Install libjpeg-turbo from sources to use the --with-pic flag.
RUN curl -o libjpeg-turbo.tar.gz -L "http://sourceforge.net/projects/libjpeg-turbo/files/1.4.2/libjpeg-turbo-1.4.2.tar.gz/download" && \
	tar xf libjpeg-turbo.tar.gz && \
	cd libjpeg-turbo-1.4.2 && \
	./configure --with-pic && \
	make install

# Install libuvc from git.
RUN commit="1539f58aa46650713bbeb2d0fa811096ca59c056" && \
	curl -o libuvc.tar.gz -L "https://github.com/pupil-labs/libuvc/archive/${commit}.tar.gz" && \
	tar xf libuvc.tar.gz && \
	cd libuvc-${commit} && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make install

# Workaround for libuvc cmake shenanigan.
RUN echo "/usr/local/lib" >> /etc/ld.so.conf && \
	ldconfig

# Install some Python packages.
RUN pip install --upgrade pip

RUN pip install \
	numexpr \
	cython \
	psutil \
	pyzmq \
	msgpack_python \
	git+https://github.com/zeromq/pyre

RUN pip install git+https://github.com/pupil-labs/PyAV@498516d0df6080018dcfe2f234557ccfcea74435
RUN pip install git+https://github.com/pupil-labs/pyuvc@v0.9
RUN pip install git+https://github.com/pupil-labs/pyndsi@4901771099afc5ee601e0c032ad0aba2037b0fd3
RUN pip install git+https://github.com/pupil-labs/pyglui@v1.2

# Download pupil source code.
RUN version="0.8.7" && \
	git clone https://github.com/pupil-labs/pupil && \
	cd pupil && \
	git checkout -b docker v${version} && \
	python pupil_src/capture/pupil_detectors/build.py && \
	python pupil_src/shared_modules/calibration_routines/optimization_calibration/build.py

WORKDIR /root/pupil/

# Set default command
CMD ["/usr/bin/bash"]
