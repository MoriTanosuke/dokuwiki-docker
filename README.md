This is a minimal docker image for [DokuWiki][0]. It is build from [Alpine Linux][1] for minimal size.

How to use
----------

Create the files *local.php*, *acl.auth.php* and *users.auth.php* according to [DokuWiki documentation][2]. They will be added when you build your own image.

Create a Dockerfile in the same directory as your configuration files:

    FROM kopis/dokuwiki

Build the Dockerfile:

    docker build -t yourname/dokuwiki .

Start your wiki:

    docker run -d --name some-dokuwiki -p 8080:80 yourname/dokuwiki

Now you can access your dokuwiki at http://localhost:8080

If you want to store the data on your host filesystem, provide a volume for */dokuwiki-data*:

    docker run -d --name some-dokuwiki -v /etc/dokuwiki-data:/dokuwiki-data -p 8080:80 yourname/dokuwiki

[0]: https://www.dokuwiki.org/
[1]: http://alpinelinux.org/

