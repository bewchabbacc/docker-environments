APIKEYS="AWS_BUCKET_NAME" "AWS_ACCESS_KEY" "AWS_SECRET_KEY" \
"DUO_AKEY" "DUO_IKEY" "DUO_SKEY" "DUO_HOST" \
"GOOGLE_CLIENTID" "GOOGLE_CLIENTSECRET" \
"FACEBOOK_CLIENTID" "FACEBOOK_CLIENTSECRET" \
"ORCHESTRATE_KEY" "STRIPE_KEY" "JWPLAYER_KEY" "SENDWITHUS_KEY" \
"JUMPCLOUD_KEY"

.PRECIOUS: .env.% .ebextensions/00credentials.%.config
.ONESHELL: .env.% .ebextensions/00credentials.%.config
.PHONY: build dev prod

# Rules for building environment

build: sa_site_v2/website/application/third_party/vendor/autoload.php

prod: clean build .ebextensions/02prod.config .ebextensions/00credentials.prod.config
dev: clean build .ebextensions/02dev.config .ebextensions/00credentials.dev.config

clean:
	-rm -rf .ebextensions/02*.config
	-rm -rf .ebextensions/00credentials.*.config

# Rules for generating files

sa_site_v2/README.md:
	git submodule init
	git submodule update

sa_site_v2/website/application/third_party/vendor/autoload.php: sa_site_v2/README.md
	echo "If you had an error about 'vendor'. Go in application/third_party and delete the old 'vendor' symlink there."
	$(MAKE) -C sa_site_v2/website/application/third_party

.env.%:
	for item in $(APIKEYS); do \
		read -p "Please enter $${item} and press ENTER: " value; \
		echo "$${item}=\"$${value}\"" >> $@; \
	done;

.ebextensions/00credentials.%.config: .env.%
	. $<
	echo 'option_settings:' > $@
	for item in $(APIKEYS); do \
		eval value=\$$$$item; \
		echo "  - option_name: $${item}\n    value: $${value}" >> $@; \
	done;
	echo "files:" >> $@;
	echo "  \"/usr/local/etc/jumpcloud_key.conf\":" >> $@;
	echo "    mode: \"000400\"" >> $@;
	echo "    owner: root" >> $@;
	echo "    group: root" >> $@;
	echo "    content: \"header = \\\"x-connect-key: $${JUMPCLOUD_KEY}\\\"\"" >> $@;

.ebextensions/02%.config: .ebextensions/%.config.template
	cp "$<" "$@"
