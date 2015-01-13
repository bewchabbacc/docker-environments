FROM debian:stable
MAINTAINER Sport Archive Inc

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

ADD https://getcomposer.org/installer /opt/composer_install.php
RUN ["php", "/opt/composer_install.php", "--install-dir=/usr/local/bin", "--filename=composer"]

COPY apache2.conf /etc/apache2/conf.d/sa_site.conf
COPY supervisor.conf /etc/supervisor/conf.d/sa_site.conf
COPY config/* /opt/sa_site/website/application/config/
COPY .ssh/* /root/.ssh/
COPY sa_site_v2 /opt/sa_site

WORKDIR /opt/sa_site/website/application/third_party
RUN ["composer", "install", "-n", "-o"]

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

EXPOSE 80
CMD ["supervisord", "-n"]
