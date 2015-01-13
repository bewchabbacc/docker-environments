FROM sportarc/sa_site-base
MAINTAINER Sport Archive Inc

ADD https://getcomposer.org/installer /opt/composer_install.php
RUN ["php", "/opt/composer_install.php", "--install-dir=/usr/local/bin", "--filename=composer"]

COPY .ssh/* /root/.ssh/
COPY sa_site_v2 /opt/sa_site
COPY config/* /opt/sa_site/website/application/config/

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
