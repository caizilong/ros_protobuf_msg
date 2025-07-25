FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
COPY apt/sources.list /etc/apt/

RUN apt-get clean && \
    apt-get autoclean
RUN apt update && \ 
    apt install  -y \
    curl \
    lsb-release \
    gnupg gnupg1 gnupg2 \
    gdb 

COPY ros-key.asc /tmp/

RUN apt-key add /tmp/ros-key.asc

RUN  sh -c '. /etc/lsb-release && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list'


RUN apt update && \
    apt install -y  ros-noetic-desktop-full \
    python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential


RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN apt update && \
    apt install -y \
    vim \
    htop \
    apt-utils \
    curl \
    cmake \
    net-tools

COPY install/abseil /tmp/install/abseil
RUN /tmp/install/abseil/install_abseil.sh

COPY install/protobuf /tmp/install/protobuf
RUN /tmp/install/protobuf/install_protobuf.sh

RUN echo "source /work/devel/setup.bash" >> ~/.bashrc

WORKDIR /work
 

