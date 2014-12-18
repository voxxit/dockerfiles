.PHONY: dovecot base push

base:
	docker build --tag r.srv.im/mail-base ./base

dovecot: base
	docker build --tag r.srv.im/mail-base ./base
	docker build --tag r.srv.im/dovecot ./dovecot

push:
	docker push r.srv.im/mail-base
	docker push r.srv.im/dovecot
