# Version: 0.0.1
FROM ubuntu:latest
MAINTAINER Tony Tsang "tonytsang@gmail.com"
RUN apt-get update
RUN apt-get -y install git openssh-server libcurl3 libpixman-1-0 libnuma1 libglib2.0-0
RUN git clone https://github.com/tonytsangzen/bogwing.git 
RUN ./bogwing/bin/qemu-system-aarch64 -version
RUN touch /.dockerenv
EXPOSE 22
