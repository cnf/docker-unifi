FROM debian:7

MAINTAINER Frank Rosquin <frank.rosquin@gmail.com>

ENV MONGO_MAJOR 3.0
ENV MONGO_VERSION 3.0.1
ENV UNIFI_VERSION 4.6.0

# RUN set -x \
        # && apt-key adv --keyserver pool.sks-keyservers.net --recv-keys 492EAFE8CD016A07919F1D2B9ECBEC467F0CEB10 \
        # && echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/$MONGO_MAJOR main" > /etc/apt/sources.list.d/mongodb-org.list

RUN set -x \
        && apt-get update \
        && apt-get install -y mongodb-server \
        && apt-get install -y openjdk-7-jre-headless jsvc wget\
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
