FROM debian:7

MAINTAINER Frank Rosquin <frank.rosquin@gmail.com>

ENV UNIFI_VERSION 4.6.3

ENV DEBIAN_FRONTEND noninteractive

RUN set -x \
        && apt-get update \
        && apt-get install -y mongodb-server openjdk-7-jre-headless jsvc wget\
        && rm -rf /var/lib/apt/lists/*

RUN set -x \
        && wget -q -O /tmp/unifi.deb http://www.ubnt.com/downloads/unifi/${UNIFI_VERSION}/unifi_sysvinit_all.deb \
        && dpkg -i /tmp/unifi.deb \
        && rm /tmp/unifi.deb \
        && rm -rf /var/lib/unifi/*

ADD ./unifi.sh /unifi.sh
RUN chmod 755 /unifi.sh


EXPOSE 8080 8081 8443 8843 8880

VOLUME ["/var/lib/unifi"]
WORKDIR /var/lib/unifi

ENTRYPOINT ["/unifi.sh"]
