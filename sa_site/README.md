Sport Archive Site Docker
=========================

This environment is for generating a Docker container for both
development and production of the main Sport Archive web
application.

In addition to the container, a Vagrant configuration is provided for
launching the machine as a development environment.

*Note: this docker image has the main source repository included as a
 Git submodule. The submodule must be initialized before the image can
 be built. The `setup.sh` script can take care of this for you, or you
 can initialize it manually.*

Credentials Setup
-----------------

In order to get the application running, there are various credentials
that must be setup, specifically:

* AWS S3
* Duo Security
* Google and Facebook OAuth
* Orchestrate.io
* Stripe
* JWplayer

There are two ways to provide these credentials to the Docker
container, depending on what you are doing:

1. If you are using Vagrant, you can run the `./setup.sh` script. This
   will prompt for your credentials and store them in a YAML file that
   will later be read by Vagrant when provisioning the machine.
2. Otherwise, you must provide the credentials to Docker at runtime as
   environment variables using the `-e` switch in docker run (an
   example of this will be provided later).

In addition to these credentials, it is recommended to set up SSH
credentials with GitHub. They are not strictly necessary, but help to
get around GitHub's absurd rate-limiting for non-logged-in users.

Running with Vagrant
--------------------

### Install Vagrant

Go to the Vagrant site and install the .deb file:
https://www.vagrantup.com/downloads

### Install VirtualBox ###

This is a free VM engine. Download and install it at:
https://www.virtualbox.org/wiki/Linux_Downloads

### Get Started ###

If you are using vagrant, simply run the `setup.sh` file once, as
mentioned above, and then run `vagrant up`.

In order to update the Docker image with new code, run `vagrant
provision`. Note: the code will not update unless you do this.

### Accessing the Instance ###

You can access the instance like any other Vagrant instance using
`vagrant ssh`. The Sport Archive website is running on port 80 of the
machine, which is forwarded to port 8080 on the host machine. In other
words, you can access the website by visiting:

    http://localhost:8080/sa-site-v2-dev/

Running without Vagrant
-----------------------

First you must build the Docker image (note: this image is based on
the base image, which is in the sibling folder):

    docker build -t sportarc/sa_site .

Then just run the image like so:

    docker run -p 80:80 -e ... sa_site

The `-p 80:80` causes port 80 to be forwarded to the machine. You may
also optionally add `-d` to have Docker run in daemon mode.

As mentioned earlier, you need to provide API credentials to the
website somehow, and it is done using the `-e` switch for environment
variables, as shown above. You will need to specify `-e key=value` for
each API key. For a list of API keys, check the `setup.sh` file.

