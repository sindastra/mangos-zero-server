FROM debian:buster

RUN apt-get update && apt-get install -y git make cmake libssl-dev libbz2-dev build-essential default-libmysqlclient-dev mariadb-client

WORKDIR /mangos/src/
RUN git clone git://github.com/sindastra/mangos-zero-server.git --recursive --depth 1 server

WORKDIR /mangos/src/server/build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=/mangos/zero -DBUILD_TOOLS=0 -DPLAYERBOTS=0 -DSOAP=0 -DDEBUG=0
RUN make -j `nproc` install

WORKDIR /mangos/zero/etc/
RUN cp mangosd.conf.dist mangosd.conf && cp realmd.conf.dist realmd.conf

WORKDIR /mangos/zero/bin/
