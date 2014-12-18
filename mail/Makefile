.PHONY: dovecot spamassassin push

dovecot:
	docker build --tag r.srv.im/dovecot ./dovecot

spamassassin:
	docker build --tag r.srv.im/spamassassin ./spamd

all: dovecot spamassassin

push: all
	docker push r.srv.im/dovecot
	docker push r.srv.im/spamassassin
