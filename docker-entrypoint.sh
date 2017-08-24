#!/bin/sh
set -e

VERSION=${VERSION:-dokuwiki-stable}
BASE_DIR=/$VERSION

# wipe previous installation
rm -rf $BASE_DIR
mkdir $BASE_DIR

echo Downloading ${VERSION}
# download dokuwiki
curl -Lqo /dokuwiki.tar.gz http://download.dokuwiki.org/src/dokuwiki/$VERSION.tgz \
	&& tar xzf /dokuwiki.tar.gz -C / \
	&& rm /dokuwiki.tar.gz

set +e

# move directories out of web root
mv $BASE_DIR/data/* /dokuwiki-data/
mv $BASE_DIR/conf/* /dokuwiki-conf/

# create preload.php
cat << EOF > $BASE_DIR/inc/preload.php
<?php
define('DOKU_CONF','/dokuwiki-conf/');
EOF

# add savedir option to local configuration
cat << EOF > /dokuwiki-conf/local.php
<?php
\$conf['savedir'] = '/dokuwiki-data';
\$conf['useacl'] = 1;
\$conf['superuser'] = @admin;
EOF

# create ACLs
cat << EOF > /dokuwiki-conf/acl.auth.php
*		@ALL		0
*		@admin		16
start		@ALL		1
EOF
# create default users
cat << EOF > /dokuwiki-conf/users.auth.php
admin:21232f297a57a5a743894a0e4a801fc3:admin:admin@localhost:admin,users,devel,support
EOF

# run dokuwiki
php -S 0.0.0.0:80 -t $BASE_DIR/

