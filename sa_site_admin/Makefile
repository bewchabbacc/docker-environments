APIKEYS="ORCHESTRATE_KEY"

.SILENT: .env
.PHONY: dev build prod env

# Rules for building environment

build: sa_site_v2/README.md .env

# Rules for generating files

sa_site_v2/README.md:
	git submodule init
	git submodule update

.ebextensions/credentials.config: .env

.env:
	echo 'option_settings:' > .ebextensions/99credentials.config
	for item in $(APIKEYS); do \
		read -p "Please enter $${item} and press ENTER: " value; \
		echo "$${item}=\"$${value}\"" >> .env; \
		echo "  - option_name: $${item}\n    value: $${value}" >> .ebextensions/99credentials.config; \
	done
