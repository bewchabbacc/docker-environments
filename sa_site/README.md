Sport Archive Site Docker
=========================

This environment is for generating a Docker container for
DEV, QA and PROD of the main Sport Archive web
application.

In addition to the container, a Vagrant configuration is provided for
launching the machine as a development environment.

*Note: this docker image has the main source repository included as a
 Git submodule. The submodule must be initialized before the image can
 be built. The Makefile can take care of this for you.*

SSH Setup
---------

Before getting started it is recommended that you create a SSH key to connect to GitHub.
If you use the Makefile to setup your environment, it is mandatory you have a key.

Follow these instructions to get you SSH key working with GitHub:
[https://help.github.com/articles/generating-ssh-keys/](https://help.github.com/articles/generating-ssh-keys/)

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

To provide all the necessary credentials to Docker, you must run the
`make` command in this directory. It will prompt for all the API keys and save
them to a `.env` file.

After running the Makefile, it will also generate an SSH key that will
be placed inside the Docker container. 

### Optional

You take this SSH key (id_ras.pub) and add it to
your GitHub account. (Similar process than adding the SSH key
before. Follow:
[https://help.github.com/articles/generating-ssh-keys/#step-3-add-your-ssh-key-to-your-account](https://help.github.com/articles/generating-ssh-keys/#step-3-add-your-ssh-key-to-your-account)

This allows you to get around GitHub's rate limits on anonymous
users. However, this is not required in order to get the container running, so
you only need to do it if you are experiencing bandwith problems. (The key is
stored in the `.ssh` folder inside this directory.)

Running with Vagrant
--------------------

### Getting Started

1. Go to the Vagrant site and install the .deb file:
   [https://www.vagrantup.com/downloads](https://www.vagrantup.com/downloads)

2. VirtualBox is a free VM engine. Download and install it at:
   [https://www.virtualbox.org/wiki/Linux_Downloads](https://www.virtualbox.org/wiki/Linux_Downloads)

3. Run `make`, as mentioned above.

4. Run `vagrant up --provision` to start the virtual machine

### Accessing the Instance ###

#### Shell Access in Docker ####

The Docker image is running inside of a Vagrant VM, so there are
multiple steps you must perform to get a shell on the container:

1. Open a local shell and navigate to this directory.
2. Run `vagrant ssh dev`, which will SSH into the VM.
3. Run `sudo docker exec -it sportarc-sa_site /bin/bash`, which will open a shell into the Docker container.

In the last command, it is telling docker to execute `/bin/bash` on
the "sportarc-sa_site" container, which is the name that Vagrant
automatically assigns.

*Note: you can substitute `/bin/bash` with any command you want and that can be executed by the Docker image.*

#### Browsing the Website ####

You can access the website by visiting:

    http://localhost:8080

This is because port 8080 on the host machine (your computer) is
forwarded to port 80 on the VM (and, in turn, port 80 on the VM is
connected to port 80 in the Docker container).

#### Accessing the Site Logs ####

The `logs/` sub-folder is synced into the Vagrant machine, which in
turn is synced into the Docker image. All logs from the Sport Archive
site will appear in this directory in the Vagrant VM.

You can easily tshoot your Codeigniter code by putting "log_message()" function.
It will get logged into: docker-environments/sa_site/logs/sa_site/

Do a 'tail -f' of the log file there to see the logs in real time.

### Coding

To start coding just go in docker-environments/sa_site/sa_site_v2.
There you have the source code in a Git repo and you can work as you usually do.

Create branches, push out code, create PR. It's business as usual.

Your code is automatically synced with the Docker container and your changes will appear live.

### Testing for Production ###

Notice how you ran `vagrant ssh dev` to access the 'dev' machine. This is
because the Vagrantfile has two possible machines it can run: prod and
dev. Up until now you have been running the dev machine.

The dev machine has one slight difference: the website code will be
synced in real-time from your host computer into the virtual
machine. In other words, as you make changes to the website, they will
appear live automatically. This feature is useful for development, but
cannot be used in production since in production the website must
actually be an unchangeable part of the Docker image.

#### Before pushing live

Before pushing to AWS for testing, it is recommended you switch to the
prod Vagrant machine first and make sure your changes still work (they should,
since there is no other difference between the two machines, but
better safe then sorry).

To change machines:

1. Run `vagrant halt dev`. This shuts down the machine so that port
   8080 is open again.
2. Run `vagrant up prod --provision`.

From here, you can use the same exact instructions above for accessing
the instance and testing the website.

In the PROD machine the code is not in sync with your local folder anymore.

Running without Vagrant
-----------------------

First you must build the Docker image (note: this image is based on
the base image, which is in the sibling folder):

    docker build -t sportarc/sa_site .

Then just run the image like so:

    docker run -p 80:80 --env-file .env sa_site

The `-p 80:80` causes port 80 to be forwarded to the machine. You may
also optionally add `-d` to have Docker run in daemon mode.

As mentioned earlier, you need to provide API credentials to the
website somehow, and it is done using the `--env-file .env` switch as
shown above. This will load the API keys from the `.env` file that is
generated by the `setup.sh` script mentioned previously. If you have
your API keys in a different file, make sure to change the filename.
