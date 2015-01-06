#!/bin/bash

export HOME="/usr/local/gogs"
export USER="git"

# make essential directories
mkdir -p ~/custom/https ~/repos

# generate ssh keys for the openssh server (unless they exist)
[ -f /etc/ssh/ssh_host_rsa_key     ] || ssh-keygen -q -N '' -b 4096 -t rsa -f /etc/ssh/ssh_host_rsa_key
[ -f /etc/ssh/ssh_host_dsa_key     ] || ssh-keygen -q -N '' -b 1024 -t dsa -f /etc/ssh/ssh_host_dsa_key
[ -f /etc/ssh/ssh_host_ecdsa_key   ] || ssh-keygen -q -N '' -b 521  -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
[ -f /etc/ssh/ssh_host_ed25519_key ] || ssh-keygen -q -N '' -b 256  -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

# generate self-signed certificate for the server's hostname (unless it exists)
mkdir -p ~/custom/https
cd ~/custom/https

if [ ! -f ~/custom/https/cert.pem ] && [ ! -f ~/custom/https/key.pem ]; then
  ~/gogs cert --host $HOSTNAME --ca true
fi

cd

# ssh security measures
sed -i "s/#Port 22/Port ${SSH_PORT:-22}/g" /etc/ssh/sshd_config
sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
sed -i "s/#PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
sed -i "s/#Protocol 2/Protocol 2/g" /etc/ssh/sshd_config
sed -i "s/#PermitEmptyPasswords no/PermitEmptyPasswords no/g" /etc/ssh/sshd_config
sed -i "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/g" /etc/ssh/sshd_config

# ensure correct permissions
chown -R git:git .

# start sshd & gogs
/usr/sbin/sshd -p ${SSH_PORT:-22}

exec /usr/local/bin/gosu git:git ~/gogs web
