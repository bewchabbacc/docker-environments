#!/bin/bash

set -u
set -e
set -o pipefail

# Re-copy over configuration files
if [ ! -f /vagrant/sa_site_admin/application/config/orchestrate.php ]; then
    cp /vagrant/config/* /vagrant/sa_site_admin/application/config/
fi
