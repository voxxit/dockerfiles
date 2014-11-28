.PHONY: dovecot base deploy

base:
		docker build --tag mail/base ./base/

dovecot: base
		docker build --tag mail/dovecot ./dovecot/

run: dovecot
		docker run -d -v /srv/vmail/:/srv/vmail/ -p 993:993 -p 25:25 --name mail mail/dovecot
