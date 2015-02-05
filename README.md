SportArchive Docker Environments
================================

This repository contains various Docker images (and sometimes
accompanying Vagrant images) for parts of the production
environment. Here is a list of the images (see the README.md inside
each folder for more information about each image and how to run it):

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
