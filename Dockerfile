FROM debian

# Based on https://www.digitalocean.com/community/tutorials/how-to-set-up-an-osrm-server-on-ubuntu-14-04

# Install dependencies
RUN apt-get update
RUN apt-get install -y build-essential git cmake
RUN apt-get install -y libboost-all-dev libtbb-dev liblua5.2-dev libluabind-dev libstxxl-dev libxml2 libxml2-dev libosmpbf-dev libbz2-dev libprotobuf-dev
RUN apt-get install -y wget

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
USER root
WORKDIR /home/renderer/src/osrm-backend/build
RUN make install
USER renderer

# configure stxxl
RUN mkdir ~/osrm
COPY .stxxl  ~/osrm/.stxxl

# configure car profile
RUN ln -s /home/renderer/src/osrm-backend/profiles/car.lua ~/osrm/profile.lua
RUN ln -s /home/renderer/src/osrm-backend/profiles/lib ~/osrm/lib


# configre run script
USER root
COPY run.sh /
RUN chmod +x /run.sh
ENTRYPOINT ["/run.sh"]
CMD []

