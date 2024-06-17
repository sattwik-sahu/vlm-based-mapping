#!/bin/bash

# Start the ROS 2 development container with GUI support and X11 forwarding
docker run -d -it --privileged \
  --net=host \
  --ipc=host \
  --env="DISPLAY" \
  -v $PWD:/home/sattwik/ros2_ws \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  --volume="${XAUTHORITY}:/root/.Xauthority" \
  -e "TERM=xterm-256color" \
  --device /dev/dri \
  --user="sattwik" \
  --name my-ros2-iron-dev \
  ros2-iron-dev
