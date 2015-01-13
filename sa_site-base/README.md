Sport Archive Site Base
=======================

This is the base image for the machine on which the Sport Archive site
runs. It does not contain the actual site or any configuration. In
fact, it's really just a basic machine running Apache +
php-fpm.

However, it can be used as a quick development environment if
necessary. (It is a better idea to just use the main image in the
other folder, which includes its own Vagrant file and all-inclusive
configuration.)

Building the Image
------------------

First you must build the Docker image:

    docker build -t sportarc/sa_site-base .

Then just run the image like so:

    docker run -p 80:80 sa_site

The `-p 80:80` causes port 80 to be forwarded to the machine. You may
also optionally add `-d` to have Docker run in daemon mode.

Creating a Dev Environment
--------------------------

If you plan on using this image as a development environment, you must
first fetch the source code for the site:

    git clone git@github.com:sportarchive/sa_site_v2

Then, when running the container, you need to mount that source code
at /opt/sa_site inside the container. This can be done as so:

    docker run -p 80:80 -v sa_site_v2:/opt/sa_site

Note: unlike the production image, you must configure the application
manually, which involves loading the composer dependencies and adding
in all the API keys (see the README for the main repository for more
information).

### Using Vagrant ###

As an alternative to running Docker directly, you can use Vagrant to
run it inside a VM. You must still clone the source code repository as
described above, but rather than running `docker run`, just run
`vagrant up` like you would for any other Vagrant image.
