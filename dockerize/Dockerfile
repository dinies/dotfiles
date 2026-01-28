#syntax = docker/dockerfile:1.2
FROM ubuntu:24.04

SHELL [ "/bin/bash" , "-c" ]
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY :0

RUN apt-get update && \
    apt-get install -qqy \
        sudo \
        git \
        curl \
        ca-certificates \
        vim \
        less \
    && rm -rf /var/lib/apt/lists/*

# Create a real user with home directory
ARG USERNAME=staging

RUN useradd -m -s /bin/bash $USERNAME && \
    usermod -aG sudo $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

CMD ["/bin/bash"]
