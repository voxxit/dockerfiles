#!/bin/bash

export HOME="$GOGSPATH"

mkdir -p $GOGSPATH/custom/https

cd $GOGSPATH/custom/https

# generate ssh keys for the openssh server (unless they exist)
test -f /etc/ssh/ssh_host_rsa_key     || ssh-keygen -q -N '' -b 4096 -t rsa -f /etc/ssh/ssh_host_rsa_key
test -f /etc/ssh/ssh_host_dsa_key     || ssh-keygen -q -N '' -b 1024 -t dsa -f /etc/ssh/ssh_host_dsa_key
test -f /etc/ssh/ssh_host_ecdsa_key   || ssh-keygen -q -N '' -b 521  -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
test -f /etc/ssh/ssh_host_ed25519_key || ssh-keygen -q -N '' -b 256  -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

# generate self-signed certificate for the server's hostname (unless it exists)
test ! -f ./cert.pem && test ! -f ./key.pem && $GOGSPATH/gogs cert --host $HOSTNAME --ca true

cd $GOGSPATH

sed -i "s/%%HOSTNAME%%/${HOSTNAME}/g" $GOGSPATH/conf/app.ini
sed -i "s|%%ROOT_URL%%|${ROOT_URL:-"https://0.0.0.0:3000"}|g" $GOGSPATH/conf/app.ini
sed -i "s/%%SECRET_KEY%%/${SECRET_KEY:-"fixme"}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%SSH_PORT%%/${SSH_PORT:-22}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%CACHE_ADAPTER%%/${CACHE_ADAPTER:-"memory"}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%CACHE_HOST%%/${CACHE_HOST}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%LOG_MODE%%/${LOG_MODE:-"console"}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%LOG_HOST%%/${LOG_HOST}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%SESSION_PROVIDER%%/${SESSION_PROVIDER:-"file"}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%SESSION_CONFIG%%/${SESSION_CONFIG:-"sessions"}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%ENABLE_OAUTH%%/${ENABLE_OAUTH:-"false"}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%GITHUB_OAUTH%%/${GITHUB_OAUTH:-"false"}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%GITHUB_CLIENT_ID%%/${GITHUB_CLIENT_ID}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%GITHUB_CLIENT_SECRET%%/${GITHUB_CLIENT_SECRET}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%SMTP%%/${SMTP:-"false"}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%SMTP_HOST%%/${SMTP_HOST}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%SMTP_FROM_ADDR%%/${SMTP_FROM_ADDR}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%SMTP_TO_ADDR%%/${SMTP_TO_ADDR}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%SMTP_USERNAME%%/${SMTP_USERNAME}/g" $GOGSPATH/conf/app.ini
sed -i "s/%%SMTP_PASSWORD%%/${SMTP_PASSWORD}/g" $GOGSPATH/conf/app.ini

# create repos directory
mkdir -p /var/lib/repos

# ensure correct permissions
chown -R git:git . /var/lib/repos

# ssh security measures
sed -i "s/#Port 22/Port ${SSH_PORT:-22}/g" /etc/ssh/sshd_config
sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
sed -i "s/#PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
sed -i "s/#Protocol 2/Protocol 2/g" /etc/ssh/sshd_config
sed -i "s/#PermitEmptyPasswords no/PermitEmptyPasswords no/g" /etc/ssh/sshd_config
sed -i "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/g" /etc/ssh/sshd_config

# start sshd
/usr/sbin/sshd -p ${SSH_PORT:-22}

# start gogs
/bin/gosu git:git ./gogs web
