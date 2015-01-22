FROM sportarc/sa_site-base
MAINTAINER Sport Archive Inc

ADD https://getcomposer.org/installer /opt/composer_install.php
RUN ["php", "/opt/composer_install.php", "--install-dir=/usr/local/bin", "--filename=composer"]

COPY .ssh/* /root/.ssh/
COPY sa_site_v2 /opt/sa_site
COPY config/* /opt/sa_site/website/application/config/

WORKDIR /opt/sa_site/website/application/third_party
RUN ["composer", "install", "-n", "-o"]

VOLUME /var/tmp/sa_site
EXPOSE 80
CMD ["supervisord", "-n"]
