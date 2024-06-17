FROM osrf/ros:iron-desktop-full


# Example of installing programs
RUN apt-get update \
    && apt-get install -y \
    vim \
    zsh \
    && rm -rf /var/lib/apt/lists/*


# Example of copying a file
# COPY config/ /site_config/


# Create a non-root user
ARG USERNAME=sattwik
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && mkdir /home/$USERNAME/.config && chown $USER_UID:$USER_GID /home/$USERNAME/.config


# Set up sudo
RUN apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/*


# Copy the entrypoint and bashrc scripts so we have 
# our container's environment set up correctly
COPY entrypoint.sh /entrypoint.sh
# COPY .bashrc /home/${USERNAME}/.bashrc

ENV TERM xterm-256color
ENV SHELL /bin/zsh

# Set up entrypoint and default command
USER ${USERNAME}

SHELL [ "/bin/zsh" ]

WORKDIR /home/${USERNAME}/ros2_ws

ENTRYPOINT ["/bin/zsh", "/entrypoint.sh"]
CMD ["/bin/zsh"]
