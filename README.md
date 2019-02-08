This is a minimal docker image for [DokuWiki][0]. It is build from [Alpine Linux][1] for minimal size. No HTTP server is used, *php* is used to serve all content. This reduces the image size further, but the image does not support *.htaccess* files and other functionality. Most likely you want to run a reverse proxy with more functionality in front.

You can find the image [on the Docker Hub][3] and the sources [on GitHub][4].

[![](https://images.microbadger.com/badges/image/moritanosuke/dokuwiki-docker.svg)](https://microbadger.com/images/moritanosuke/dokuwiki-docker)

How to use
----------

Create volumes for data and configuration:

    docker volume create dokuwiki_conf
    docker volume create dokuwiki_data

Start your wiki:

    docker run -d --name some-dokuwiki -p 8080:80 -v dokuwiki_conf:/dokuwiki-conf -v dokuwiki_data:/dokuwiki-data moritanosuke/dokuwiki-docker

Now you can access your dokuwiki at http://localhost:8080

Backup your data
----------------

To get a copy of your wiki data, run the following command:

    docker run --rm -v dokuwiki_data:/data -v $(pwd):/backup alpine:latest tar czf /backup/dokuwiki-data.tgz /data

Restore your data
-----------------

After you started a new dokuwiki container, you can restore your previous backup with the following command:

    docker run --rm -v dokuwiki_data:/data -v $(pwd):/backup alpine:latest tar xzf /backup/dokuwiki-data.tgz /data

[0]: https://www.dokuwiki.org/
[1]: http://alpinelinux.org/
[2]: https://www.dokuwiki.org/config#configuration_options
[3]: https://hub.docker.com/r/moritanosuke/dokuwiki-docker/
[4]: https://github.com/MoriTanosuke/dokuwiki-docker
