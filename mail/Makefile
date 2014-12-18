.PHONY: dovecot base push

base:
	docker build --tag r.srv.im/mail-base ./base

dovecot: base
	docker build --tag r.srv.im/dovecot ./dovecot

spamassassin: base
  docker build --tag r.srv.im/spamassassin ./spamd

push:
	docker push r.srv.im/mail-base
	docker push r.srv.im/dovecot
	docker push r.srv.im/spamd
