#!/bin/bash

set -euo -o pipefail

# Re-copy over configuration files
if [ ! -f /vagrant/sa_site_v2/website/application/config/sessions.php ]; then
    cp /vagrant/config/* /vagrant/sa_site_v2/website/application/config/
fi

cp /vagrant/config/sessions_dev.php /vagrant/sa_site_v2/website/application/config/sessions.php
