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
"JWPLAYER_KEY" \
"SENDWITHUS_KEY"

.SILENT: .env
.PHONY: dev build prod env


# Rules for building environment

build: sa_site_v2/website/application/third_party/vendor/autoload.php .env

prod: clean build .ebextensions/02prod.config
dev: clean build .ebextensions/02dev.config

clean:
	-rm -rf .ebextensions/02*.config


# Rules for generating files

.ebextensions/02%.config: .ebextensions/%.config.template
	cp "$<" "$@"

sa_site_v2/README.md:
	git submodule init
	git submodule update

sa_site_v2/website/application/third_party/vendor/autoload.php: sa_site_v2/README.md
	$(MAKE) -C sa_site_v2/website/application/third_party
	echo "If you had an error about 'vendor'. Go in application/third_party and delete the old 'vendor' symlink there."

.ebextensions/00credentials.config: .env

.env:
	echo 'option_settings:' > .ebextensions/900credentials.config
	for item in $(APIKEYS); do \
		read -p "Please enter $${item} and press ENTER: " value; \
		echo "$${item}=\"$${value}\"" >> .env; \
		echo "  - option_name: $${item}\n    value: $${value}" >> .ebextensions/00credentials.config; \
	done; \
	read -p "Please enter JUMPCLOUD_KEY and press ENTER (leave blank for DEV): " value; \
	echo "files:" >> .ebextensions/00credentials.config; \
	echo "  \"/usr/local/etc/jumpcloud_key.conf\":" >> .ebextensions/00credentials.config; \
	echo "    mode: \"000400\"" >> .ebextensions/00credentials.config; \
	echo "    owner: root" >> .ebextensions/00credentials.config; \
	echo "    group: root" >> .ebextensions/00credentials.config; \
	echo "    content: \"header = \\\"x-connect-key: $${value}\\\"\"" >> .ebextensions/00credentials.config; \
