SportArchive Docker Environments
================================

This repository contains various Docker images (and sometimes
accompanying Vagrant images) for parts of the production
environment. Here is a list of the images (see the README.md inside
each folder for more information about each image and how to run it):

* **sa_site-base**: A base image running Apache and PHP-FPM with some
  necessary Apache modules loaded. Can be used as a cheap development
  environment.
* **sa_site**: The main site, based on the base image. Note: you will
  need permission to read from the main source code repository in
  order to build this image (it is loaded in as a Git submodule).

Docker Terminology
------------------

Here are some quick terms that you should know concerning Docker and
its components:

* **Image**: An image is an immutable box, similar to a VM snapshot or
  an AMI on AWS. It contains a filesystem with all the necessary
  packages on it for running a specific application.
* **Container**: A container is an instance of an image. In other
  words, if an image is a VM snapshot, a container is the actual VM
  running. You can have multiple containers running the same image.
* **Dockerfile**: This is a file that describes the steps used to
  create an image. It is kind of like a Makefile for Docker images.

Which image should I use?
-------------------------

As listed above, there are two images: `sa_site-base` and
`sa_site`. The base image is just the operating system, with Apache
and PHP installed, and any configuration files therein. The main image
is based on the base image, and contains the actual website source
code.

The main image is what is used in production when launching on the
cluster. However, since the source code for the website is inside the
image, it becomes difficult to develop, since you have to rebuild the
image and launch a new container every time you change code.

Therefore, it is recommended you use the base image for regular
development. (See the README for the base image for how to do that.)
However, always make sure to test using the main image, since that is
what will actually be deployed.
