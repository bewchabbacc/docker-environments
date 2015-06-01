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

Clone this repo
---------------

Yeah! to work you need to clone this repo locally. No need to fork it
unless you want to submit a Pull Request because you've made an
improvement.

Once cloned locally, to work on the SA site: Go to the sub-module
'sa_site_v2' located in 'docker-environments/sa_site/sa_site_v2'.

Just follow the instructions below to get your environment setup.

Credentials Setup
-----------------

Ask the administrator to create your credentials and all your API keys
before moving to next step.

In order to get the application running, there are various credentials
that must be setup, specifically:

* AWS S3
* Duo Security
* Google and Facebook OAuth
* Orchestrate.io
* Stripe
* JWplayer

To provide all the necessary credentials to Docker, you will run the
`make dev` command on your local machine from this directory (see below).
It will prompt for all the API keys and save them to a `.env.dev` file.

For both the Makefile and Vagrantfile, there are multiple "environments"
you can use, which allow for specifying different sets of API keys.

* Run `make dev` to setup a file with all your dev environment creds.
* Run `make prod` to setup a file with all your prod environment creds.

You can switch seamlessly between the two by running either command. It
will only ask for your API keys once.

Git Setup
---------

This repository uses [Git submodules](http://git-scm.com/book/en/v2/Git-Tools-Submodules)
in order to load the website source code.

When you clone this repository and run `make`, the Makefile is set to automatically run
`git submodule init` and `git submodule update`. So you do not have to do much to set
up your development environment.

However, since we use GitHub pull requests, the one thing you have to do is change over
the website's remote repository to your fork rather than the main repository. To do this:

1. Run `make`.
2. Move into the `sa_site_v2` directory. This directory is where the website code lives. It is an
   independent git repository, a git submodule and it points to the website's codebase.
3. Run `git remote rename origin upstream`. This renames the main remote repository so
   you can still pull from it.
4. Run `git remote add origin <MY_FORK_URL>`, replacing "MY_FORK_URL" with the URL of
   your repository.

And you're done!


Running with Vagrant
--------------------

Vagrant will create a VM on your machine. Inside this VM we run Docker which runs Apache and the site.

### Getting Started

1. Go to the Vagrant site and install the .deb file:
   [https://www.vagrantup.com/downloads](https://www.vagrantup.com/downloads)

2. VirtualBox is a free VM engine. Download and install it at:
   [https://www.virtualbox.org/wiki/Linux_Downloads](https://www.virtualbox.org/wiki/Linux_Downloads)

3. In your clone, in the "sa_site" folder, run `make` if not already done before. You will be prompt for all your keys. Check your credential document.

4. Run `vagrant up dev` to start the virtual machine and the Docker container inside the VM

Note: Always make sure you have the latest version of the docker-environment project locally. Run a `git pull origin master` to update the project.

### Accessing the Instance ###

#### Shell Access in Docker ####

The Docker image is running inside of a Vagrant VM, so there are
multiple steps you must perform to get a shell on the container:

1. Open a local shell and navigate to this "sa_site" directory.
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

To start coding just go to docker-environments/sa_site/sa_site_v2.
There you have the source code in a Git repo and you can work as you usually do.

Always make sure the website code in sa_site_v2 is up to date.
Run:
```
git checkout master
git pull upstream master
```
If you see fresh updates coming in from the upstream repo, push them out to your fork.
Run:
```
git push origin master
```

Only then you are ready.
Create branches, push out code, create PR. It's business as usual.

Your code is automatically synced with the running Docker container and your changes will appear live on your local site at http://localhost:8080.

Running without Vagrant
-----------------------

First you must build the Docker image (note: this image is based on
the base image, which is in the sibling folder):

    docker build -t sportarc/sa_site .

Then just run the image like so:

    docker run memcached
    docker run -p 80:80 --link memcached:memcached \
       -e MEMCACHED_ENDPOINT='memcached' --env-file .env sa_site

The `-p 80:80` causes port 80 to be forwarded to the machine. You may
also optionally add `-d` to have Docker run in daemon mode. The
`--link` option links together the memcached and main container.

As mentioned earlier, you need to provide API credentials to the
website somehow, and it is done using the `--env-file .env` switch as
shown above. This will load the API keys from the `.env` file that is
generated by the `Makefile` script mentioned previously. 

If you have your API keys in a different file, make sure to change the filename.
