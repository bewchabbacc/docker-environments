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
