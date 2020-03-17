FROM debian:buster

RUN apt-get update && apt-get install -y git make cmake libssl-dev libbz2-dev build-essential default-libmysqlclient-dev mariadb-client
RUN mkdir -p /mangos/src && mkdir -p /mangos/zero && mkdir -p /mangos/data && git clone git://github.com/sindastra/mangos-zero-server.git --recursive --depth 1 /mangos/src/server
RUN rm -rf /mangos/src/server/build; mkdir -p /mangos/src/server/build && cd /mangos/src/server/build && cmake .. -DCMAKE_INSTALL_PREFIX=/mangos/zero -DBUILD_TOOLS=0 -DPLAYERBOTS=0 -DSOAP=0 -DDEBUG=0
RUN cd /mangos/src/server/build && make -j `nproc` install && cp /mangos/zero/etc/mangosd.conf.dist /mangos/zero/etc/mangosd.conf && cp /mangos/zero/etc/realmd.conf.dist /mangos/zero/etc/realmd.conf
