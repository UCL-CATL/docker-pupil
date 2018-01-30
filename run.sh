#!/usr/bin/env bash

# Usages:
# ./run.sh
# ./run.sh /path/where/recordings/should/be/saved

# Normally a container offers greater security, but it is not the case if you
# run the container with this script, since the privileged mode and net=host
# are used. So you need to trust the software installed inside the container.
# But a container offers other advantages, as explained in the README.md file.
#
# However, it should be entirely feasible to have a more confined container:
# - Instead of --privileged, provide a list of --device (but it's maybe not
#   sufficient).
# - Instead of --net=host, --publish a port.
#
# Rationale for the options:
# - privileged: to be able to access the webcam devices, the graphics card
#   device, etc.
# - net=host: to configure more easily the IP address and port of the Pupil
#   Broadcast Server.
# - DISPLAY, XSOCK and XAUTH: needed for a GUI application.

if [ "$#" -lt "1" ]; then
	recordings_dir=~/pupil/recordings
else
	recordings_dir=$1
fi

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
> $XAUTH
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run -it --rm \
	--privileged \
	--net=host \
	--env DISPLAY=$DISPLAY \
	--volume $XSOCK:$XSOCK \
	--volume $XAUTH:$XAUTH --env XAUTHORITY=$XAUTH \
	--volume $recordings_dir:/root/pupil/recordings \
	ucl-cosy/ubuntu-pupil:u17.10-p1.2
