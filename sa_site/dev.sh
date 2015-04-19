#!/bin/bash

set -u
set -e
set -o pipefail

# Re-establish the symbolic link to composer's vendor directory
if [ ! -e /vagrant/sa_site_v2/website/application/third_party/vendor ]; then
    /usr/bin/docker exec sportarc-sa_site \
		    ln -sf /opt/third_party /opt/sa_site/website/application/third_party/vendor
fi

# Re-copy over configuration files
if [ ! -f /vagrant/sa_site_v2/website/application/config/sessions.php ]; then
    cp /vagrant/config/* /vagrant/sa_site_v2/website/application/config/
fi

cp /vagrant/config/sessions_dev.php /vagrant/sa_site_v2/website/application/config/sessions.php
