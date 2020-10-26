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
cp -af $BASE_DIR/data/* /dokuwiki-data/
cp -af $BASE_DIR/lib/plugins/* /dokuwiki-plugins/
rm -rf $BASE_DIR/lib/plugins/
ln -s /dokuwiki-plugins $BASE_DIR/lib/plugins

#do not replace the configs if we find existing ones
if [ ! -f "/dokuwiki-conf/local.php" ]; then
 echo "creating initial config ...";
 cp -af $BASE_DIR/conf/* /dokuwiki-conf/
fi
# create preload.php
cat << EOF > $BASE_DIR/inc/preload.php
<?php
define('DOKU_CONF','/dokuwiki-conf/');
EOF

#only change the config if we don't find existing ones
if [ ! -f "/dokuwiki-conf/local.php" ]; then
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
fi

# remove unused files
grep -Ev '^($|#)' /dokuwiki-data/deleted.files | xargs -n 1 rm -f

# run dokuwiki
php5 -S 0.0.0.0:80 -t $BASE_DIR/
