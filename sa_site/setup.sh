#!/bin/bash

set -euo pipefail

if [ ! -f "sa_site_v2/README.md" ]; then
    git submodule init
    git submodule update
fi

if [ ! -f ".env" ]; then
    # Gather API keys for the application
    items=(
	"AWS_BUCKET_NAME"
	"AWS_ACCESS_KEY"
	"AWS_SECRET_KEY"
	"DUO_AKEY"
	"DUO_IKEY"
	"DUO_SKEY"
	"DUO_HOST"
	"GOOGLE_CLIENTID"
	"GOOGLE_CLIENTSECRET"
	"FACEBOOK_CLIENTID"
	"FACEBOOK_CLIENTSECRET"
	"ORCHESTRATE_KEY"
	"STRIPE_KEY"
	"JWPLAYER_KEY"
    );

    output=''
    for item in ${items[@]}; do
	read -p "Please enter ${item} and press ENTER: " value;
	output="${output}\n${item}=\"${value}\"";
    done

    echo -e "${output}" > .env
fi

if [ ! -f ".ssh/id_rsa" ]; then
    ssh-keygen -b 8192 -f ".ssh/id_rsa";

    echo -e "\n\ATTENTION: Make sure to add the new SSH key to GitHub."
fi
