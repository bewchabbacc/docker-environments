FROM ubuntu:trusty
MAINTAINER Sport Archive Inc

ENV DEBIAN_FRONTEND noninteractive
ENV TERM screen

# Base system requirements
RUN apt-get update && apt-get install -y \
  apache2 \
  apache2-mpm-event \
  ca-certificates \
  php-pear \
  php5-curl \
  php5-fpm \
  supervisor \
  nano

# Apache and php-fpm configuration
RUN mkdir -p /var/run/apache2
RUN mkdir -p /var/lock/apache2
RUN chown www-data:www-data /var/lock/apache2

# Install ElastiCache extension
COPY system/php5/elasticache.tar.gz /etc/php5/
RUN pecl install /etc/php5/elasticache.tar.gz

# Copy config files in...
COPY system/supervisor.conf /etc/supervisor/conf.d/sa_site_admin.conf
COPY system/apache2/keys.conf /etc/apache2/keys.conf
COPY system/apache2/global.conf /etc/apache2/conf-available/sa_site_admin.conf
COPY system/apache2/vhost.conf /etc/apache2/sites-available/sa_site_admin.conf
COPY system/php5/elasticache.ini /etc/php5/mods-available/elasticache.ini
COPY system/php5/global.ini /etc/php5/mods-available/sa_site_admin.ini
COPY system/php5-fpm/sa_site_admin.conf /etc/php5/fpm/pool.d/sa_site_admin.conf

# ...and then enable them
RUN a2enmod \
  actions \
  alias \
  authn_file \
  env \
  proxy_fcgi \
  rewrite
RUN a2enconf sa_site_admin
RUN a2dissite 000-default
RUN a2ensite sa_site_admin
RUN php5enmod sa_site_admin elasticache

# Site and site configuration
COPY sa_site_admin /opt/sa_site_admin
COPY config/* /opt/sa_site_admin/website/application/config/
RUN mkdir -p /var/log/sa_site_admin /var/log/php5 /var/log/apache2
RUN chown www-data:www-data /var/log/sa_site_admin /var/log/php5 /var/log/apache2

# Environment variables
ENV VIRTUALHOST sportarchive.tv
ENV ENVIRONMENT prod
ENV MEMCACHED_ENDPOINT localhost
ENV FORCE_AUTH 0

ENV AWS_ACCESS_KEY xyz
ENV AWS_SECRET_KEY xyz
ENV DUO_AKEY xyz
ENV DUO_IKEY xyz
ENV DUO_SKEY xyz
ENV DUO_HOST xyz
ENV ORCHESTRATE_KEY xyz
ENV SENDWITHUS_KEY xyz

# Log volumes
VOLUME /var/log/sa_site_admin
VOLUME /var/log/apache2
VOLUME /var/log/php5
VOLUME /var/log/supervisor
EXPOSE 80
CMD ["supervisord", "-n"]
