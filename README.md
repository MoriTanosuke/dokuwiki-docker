This is a minimal docker image for [DokuWiki][0]. It is build from [Alpine Linux][1] for minimal size.

[![](https://badge.imagelayers.io/moritanosuke/dokuwiki-docker:latest.svg)](https://imagelayers.io/?images=moritanosuke/dokuwiki-docker:latest 'Get your own badge on imagelayers.io')

How to use
----------

Create the files *local.php*, *acl.auth.php* and *users.auth.php* according to [DokuWiki documentation][2]. They will be added when you build your own image.

Create a Dockerfile in the same directory as your configuration files:

    FROM moritanosuke/dokuwiki-docker

Build the Dockerfile:

    docker build -t yourname/dokuwiki .

Start your wiki:

    docker run -d --name some-dokuwiki -p 8080:80 yourname/dokuwiki

Now you can access your dokuwiki at http://localhost:8080

Backup your data
----------------

To get a copy of your wiki data, run the following command when the dokuwiki container is up:

    docker cp some-dokuwiki:/dokuwiki-data .

Restore your data
-----------------

After you started a new dokuwiki container, you can restore your previous backup with the following command:

    docker cp dokuwiki-data some-new-dokuwiki:/

[0]: https://www.dokuwiki.org/
[1]: http://alpinelinux.org/
[2]: https://www.dokuwiki.org/config#configuration_options
