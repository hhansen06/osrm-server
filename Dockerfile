FROM ubuntu:18.04

# Based on https://www.digitalocean.com/community/tutorials/how-to-set-up-an-osrm-server-on-ubuntu-14-04

# Install dependencies
RUN apt-get update
RUN apt-get install -y build-essential git cmake
RUN apt-get install -y libboost-all-dev libtbb-dev liblua5.2-dev libluabind-dev libstxxl-dev libxml2 libxml2-dev libosmpbf-dev libbz2-dev libprotobuf-dev


# Set up environment and renderer user
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN adduser --disabled-password --gecos "" renderer
USER renderer

# Install latest osrm-backend
RUN mkdir /home/renderer/src
WORKDIR /home/renderer/src
RUN git clone https://github.com/Project-OSRM/osrm-backend.git
WORKDIR /home/renderer/src/osrm-backend
RUN mkdir build
WORKDIR /home/renderer/src/osrm-backend/build
RUN cmake ..
RUN sudo make install


# configure stxxl
RUN mkdir ~/osrm
COPY .stxxl  ~/osrm/.stxxl

