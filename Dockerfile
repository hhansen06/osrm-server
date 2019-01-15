FROM ubuntu:18.04

# Install dependencies
RUN apt update
RUN apt install -y build-essential git cmake
RUN apt install -y libboost-all-dev libtbb-dev liblua5.2-dev libluabind-dev libstxxl-dev libxml2 libxml2-dev libosmpbf-dev libbz2-dev libprotobuf-dev
