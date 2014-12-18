.PHONY: dovecot spamassassin push

dovecot:
	docker build --tag r.srv.im/dovecot ./dovecot

spamassassin:
	docker build --tag r.srv.im/spamassassin ./spamd

mailpile:
	docker build --tag voxxit/mailpile ./mailpile

all: dovecot spamassassin mailpile

push: all
	docker push r.srv.im/dovecot
	docker push r.srv.im/spamassassin
	docker push voxxit/mailpile
