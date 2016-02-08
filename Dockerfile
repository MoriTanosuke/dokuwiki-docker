FROM	alpine
MAINTAINER Carsten Ringe <carsten@kopis.de>

EXPOSE	80

RUN	apk update && apk add -U php-cli php-mysqli php-ctype php-xml php-gd php-zlib php-openssl php-curl php-opcache php-json curl

# download piwik and moving into /usr/src/piwik
RUN	curl -o dokuwiki.tar.gz http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz \
	&& tar xzf dokuwiki.tar.gz \
	&& mv dokuwiki-* /www \
	&& mv /www/data /dokuwiki-data \
	&& mv /www/conf /dokuwiki-conf \
	&& rm dokuwiki.tar.gz

# add preload.php to move conf directory
ADD	preload.php /www/inc/preload.php

# add directories
RUN	mkdir -p /dokuwiki-conf
RUN	mkdir -p /dokuwiki-data

# create local.php with necessary configuration
RUN	echo "<?php \$conf['savedir'] = '/dokuwiki-data';" > /dokuwiki-conf/local.php

CMD	["php", "-S", "0.0.0.0:80", "-t", "/www/"]

