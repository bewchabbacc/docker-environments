APIKEYS="AWS_BUCKET_NAME" \
"AWS_ACCESS_KEY" \
"AWS_SECRET_KEY" \
"DUO_AKEY" \
"DUO_IKEY" \
"DUO_SKEY" \
"DUO_HOST" \
"GOOGLE_CLIENTID" \
"GOOGLE_CLIENTSECRET" \
"FACEBOOK_CLIENTID" \
"FACEBOOK_CLIENTSECRET" \
"ORCHESTRATE_KEY" \
"STRIPE_KEY" \
"JWPLAYER_KEY"

.SILENT: .env
.PHONE: dev

dev: sa_site_v2/README.md .env .ssh/id_rsa

sa_site_v2/README.md:
	git submodule init
	git submodule update

.ssh/id_rsa:
	ssh-keygen -b 8192 -f ".ssh/id_rsa";
	echo echo -e "\n\ATTENTION: Make sure to add the new SSH key to GitHub."

.ebextensions/credentials.config: .env

.env:
	echo 'option_settings:' > .ebextensions/99credentials.config
	for item in $(APIKEYS); do \
		read -p "Please enter $${item} and press ENTER: " value; \
		echo "$${item}=\"$${value}\"" >> .env; \
		echo "  - option_name: $${item}\n    value: $${value}" >> .ebextensions/99credentials.config; \
	done
