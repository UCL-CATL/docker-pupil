# https://github.com/UCL-CATL/cosy-docker-layer
FROM ucl-cosy/cosy-docker-layer

MAINTAINER Sébastien Wilmet

RUN dnf -y builddep libjpeg-turbo && \
	dnf -y install \
		boost-devel \
		ceres-solver-devel \
		cmake \
		eigen3-devel \
		ffmpeg \
		ffmpeg-devel \
		gflags-devel \
		glew-devel \
		glfw-devel \
		glog-devel \
		libusb-devel \
		mesa-libGLU-devel \
		opencv-devel \
		opencv-python \
		python2-pyopengl \
		python2-scipy \
		python-devel && \
	dnf clean all

WORKDIR /root/

# Install libjpeg-turbo from sources to use the --with-pic flag.
RUN curl -o libjpeg-turbo.tar.gz -L "http://sourceforge.net/projects/libjpeg-turbo/files/1.4.2/libjpeg-turbo-1.4.2.tar.gz/download" && \
	tar xf libjpeg-turbo.tar.gz && \
	cd libjpeg-turbo-1.4.2 && \
	./configure --with-pic && \
	make install

# Install libuvc from git.
RUN commit="59b7e2ef516f3c22864cc7e80a44ffc9e5fe0194" && \
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
	https://github.com/zeromq/pyre/archive/master.zip

# Install PyAV.
RUN commit="498516d0df6080018dcfe2f234557ccfcea74435" && \
	curl -o PyAV.tar.gz -L "https://github.com/pupil-labs/PyAV/archive/${commit}.tar.gz" && \
	tar xf PyAV.tar.gz && \
	cd PyAV-${commit} && \
	python setup.py install

# Install pyuvc.
RUN version="0.7" && \
	curl -o pyuvc.tar.gz -L "https://github.com/pupil-labs/pyuvc/archive/v${version}.tar.gz" && \
	tar xf pyuvc.tar.gz && \
	cd pyuvc-${version} && \
	python setup.py install

# Install pyglui.
# It doesn't work from the tarball because there are some git submodules. So do a git clone instead.
RUN version="0.8" && \
	git clone http://github.com/pupil-labs/pyglui && \
	cd pyglui && \
	git checkout -b docker v${version} && \
	git submodule update --init --recursive && \
	python setup.py install

# Download pupil source code.
RUN version="0.7.6" && \
	git clone https://github.com/pupil-labs/pupil && \
	cd pupil && \
	git checkout -b docker v${version} && \
	python pupil_src/capture/pupil_detectors/build.py && \
	python pupil_src/shared_modules/calibration_routines/optimization_calibration/build.py

WORKDIR /root/pupil/

# Set default command
CMD ["/usr/bin/bash"]
