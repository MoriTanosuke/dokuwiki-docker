FROM	alpine:3.13
MAINTAINER Carsten Ringe <carsten@kopis.de>

EXPOSE 80
VOLUME ["/dokuwiki-data", "/dokuwiki-conf", "/dokuwiki-plugins"]
ARG VERSION=dokuwiki-2020-07-29
ENV VERSION=$VERSION

RUN apk update && apk add -U \
    curl \
    php7-cli \
    php7-ctype \
    php7-curl \
    php7-gd \
    php7-json \
    php7-ldap \
    php7-mysqli \
    php7-opcache \
    php7-openssl \
    php7-session \
    php7-xml \
    php7-zlib

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

CMD	["/docker-entrypoint.sh"]
