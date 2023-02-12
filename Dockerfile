#syntax = docker/dockerfile:1.2
ARG base_image
FROM ${base_image} AS final


SHELL [ "/bin/bash" , "-c" ]
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY :0

RUN apt-get update && \
  apt-get install -qqy --no-install-recommends \
  sudo git keyboard-configuration tzdata

# RUN echo "tzdata tzdata/Areas select Europe" | debconf-set-selections &&\
#   echo "tzdata tzdata/Zones/Europe select Paris" | debconf-set-selections

ARG uid
ARG gid
ARG user
ENV USERNAME $user
ARG group=${user}
ENV HOME /home/${user} 
# sudoers 
RUN groupadd -g ${gid} ${group}
RUN useradd -c "${user} user" -d $HOME -u ${uid} -g ${gid} -m ${user} && \
  usermod -aG sudo ${user} && \
  echo "${user} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#avoid deletion of apt packages for caching purposes
RUN rm -f /etc/apt/apt.conf.d/docker-clean

WORKDIR /home/${user}

USER ${user}
RUN mkdir -p /home/${user}/dotfiles
COPY --chown=${user}:${user} . /home/${user}/dotfiles
RUN rm -rf /home/${user}/dotfiles/vim/bundle/*  &&\
  /home/${user}/dotfiles/set_up.sh
CMD ["/bin/bash"]
