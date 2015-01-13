FROM debian:stable
MAINTAINER Sport Archive Inc

# Base system requirements
ADD debian-nonfree.list /etc/apt/sources.list.d/
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
COPY apache2.conf /etc/apache2/conf.d/sa_site.conf
COPY supervisor.conf /etc/supervisor/conf.d/sa_site.conf

EXPOSE 80
CMD ["supervisord", "-n"]
