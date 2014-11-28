.PHONY: dovecot base deploy

base:
	docker build \
		--tag voxxit/mail-base ./base/

dovecot: base
	docker build \
		--tag voxxit/mail-dovecot ./dovecot/

run: dovecot
	docker run -d --restart always -v /root/data/mail:/srv/vmail --dns 8.8.4.4 --dns 8.8.8.8 -p 465:465 -p 587:587 -p 993:993 -h mail.srv.im --name mail.srv.im voxxit/mail-dovecot
