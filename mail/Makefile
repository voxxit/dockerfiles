.PHONY: dovecot base deploy

base:
	docker build \
		--tag voxxit/mail-base ./base/

dovecot: base
	docker build \
		--tag voxxit/mail-dovecot ./dovecot/

run: dovecot
	docker run \
		--detach \
		--restart always \
		--volume /srv/vmail/:/srv/vmail/ \
		--dns 8.8.8.8 \
		--publish 25:25 \
		--publish 465:465 \
		--publish 587:587 \
		--publish 993:993 \
		--hostname mail.srv.im \
		--name mail.srv.im \
			voxxit/mail-dovecot
