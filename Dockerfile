FROM ubuntu:latest

MAINTAINER "Andrew Rothstein" <andrew.rothstein@gmail.com>

ENV TRANSMISSION_VER 2.84
RUN apt-get -y update ;\
 apt-get -y install wget build-essential automake autoconf libtool pkg-config intltool libcurl4-openssl-dev libglib2.0-dev libevent-dev libminiupnpc-dev libappindicator-dev ;\
 wget https://transmission.cachefly.net/transmission-${TRANSMISSION_VER}.tar.xz ;\
 tar xvf transmission-${TRANSMISSION_VER}.tar.xz ;\
 cd transmission-${TRANSMISSION_VER} ;\
 ./configure -q ;\
 make -s ;\
 make install ;\
 rm -rf transmission-${TRANSMISSION_VER} transmission-${TRANSMISSION_VER}.tar.xz

ADD files/transmission-daemon /etc/transmission-daemon
ADD files/run_transmission.sh /run_transmission.sh

VOLUME ["/var/lib/transmission-daemon/downloads"]
VOLUME ["/var/lib/transmission-daemon/incomplete"]

EXPOSE 9091
EXPOSE 12345

CMD ["/run_transmission.sh"]
