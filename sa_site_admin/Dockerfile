FROM debian:stable
MAINTAINER Sport Archive Inc

ENV DEBIAN_FRONTEND noninteractive

# Base system requirements
ADD system/debian-nonfree.list /etc/apt/sources.list.d/
RUN apt-get update && apt-get install -y \
  apache2 \
  apache2-mpm-event \
  ca-certificates \
  libapache2-mod-fastcgi \
  git \
  php5-cli \
  php5-curl \
  php5-fpm \
  supervisor

RUN a2enmod \
  actions \
  alias \
  env \
  fastcgi \
  rewrite

# Apache and php-fpm configuration
COPY system/apache2.conf /etc/apache2/conf.d/sa_site.conf
COPY system/apache2-vhost.conf /etc/apache2/sites-available/sa_site_admin
COPY system/supervisor.conf /etc/supervisor/conf.d/sa_site_admin.conf
COPY system/php.ini /etc/php5/conf.d/99-sa_site_admin.conf
RUN a2dissite default
RUN a2ensite sa_site_admin

# ADD https://getcomposer.org/installer /opt/composer_install.php
# RUN ["php", "/opt/composer_install.php", "--install-dir=/usr/local/bin", "--filename=composer"]

# Site and site configuration
COPY sa_site_admin /opt/sa_site_admin

# Composer dependencies for site
# RUN mkdir -p /opt/third_party && ln -s /opt/third_party /opt/sa_site/application/third_party/vendor
# WORKDIR /opt/sa_site/application/third_party
# RUN ["composer", "install", "-n", "-o"]

# Environment variables
ENV VIRTUALHOST sportarchive.tv
ENV ENVIRONMENT prod

ENV ORCHESTRATE_KEY xyz

# Log volumes
VOLUME /var/tmp/sa_site
VOLUME /var/log/apache2
VOLUME /var/log/php5
EXPOSE 80
CMD ["supervisord", "-n"]
