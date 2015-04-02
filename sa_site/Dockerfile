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
  php-pear \
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
COPY system/apache2-vhost.conf /etc/apache2/sites-available/sa_site
COPY system/supervisor.conf /etc/supervisor/conf.d/sa_site.conf
COPY system/php.ini /etc/php5/conf.d/99-sa_site.ini
COPY system/php5-elasticache.ini /etc/php5/conf.d/01-elasticache.conf
COPY system/php5-elasticache.tar.gz /etc/php5/
RUN pecl install /etc/php5/php5-elasticache.tar.gz
RUN a2dissite default
RUN a2ensite sa_site

ADD https://getcomposer.org/installer /opt/composer_install.php
RUN ["php", "/opt/composer_install.php", "--install-dir=/usr/local/bin", "--filename=composer"]

# Site and site configuration
COPY .ssh/* /root/.ssh/
COPY sa_site_v2 /opt/sa_site
COPY config/* /opt/sa_site/website/application/config/
COPY config/jwplayer.php /opt/sa_site/website/application/modules/user/widgets/jwplayer/config/

# Composer dependencies for site
RUN mkdir -p /opt/third_party && ln -s /opt/third_party /opt/sa_site/website/application/third_party/vendor
WORKDIR /opt/sa_site/website/application/third_party
RUN ["composer", "install", "-n", "-o"]

# Environment variables
ENV VIRTUALHOST sportarchive.tv
ENV ENVIRONMENT prod
ENV MEMCACHED_ENDPOINT localhost

ENV AWS_BUCKET_NAME xyz
ENV AWS_ACCESS_KEY xyz
ENV AWS_SECRET_KEY xyz
ENV DUO_AKEY xyz
ENV DUO_IKEY xyz
ENV DUO_SKEY xyz
ENV DUO_HOST xyz
ENV GOOGLE_CLIENTID xyz
ENV GOOGLE_CLIENTSECRET xyz
ENV FACEBOOK_CLIENTID xyz
ENV FACEBOOK_CLIENTSECRET xyz
ENV ORCHESTRATE_KEY xyz
ENV STRIPE_KEY xyz
ENV JWPLAYER_KEY xyz
ENV SENDWITHUS_KEY xyz

# Log volumes
VOLUME /var/tmp/sa_site
VOLUME /var/log/apache2
VOLUME /var/log/php5
EXPOSE 80
CMD ["supervisord", "-n"]
