#!/bin/bash

docker exec -it \
  -t \
  -e "color_prompt=yes" \
  -e "TERM=xterm-256color" \
  my-ros2-iron-dev \
  /bin/zsh
