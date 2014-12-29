To start a master:

```
docker run \
  -d \
  -p 4505:4505/tcp \
  -p 4506:4506/tcp \
  -p 4510:4510/udp \
  -v /dev/log:/dev/log \
  -v /etc/salt:/etc/salt \
  -v /srv/salt:/srv/salt \
  -v /var/log/salt:/var/log/salt \
  -h salt \
  --restart on-failure:10 \
  --name salt-master \
  --link redis:redis \
  salt master
```

To start a minion:

```
docker run \
  -d \
  -v /dev/log:/dev/log \
  -v /etc/salt:/etc/salt \
  -v /srv/salt:/srv/salt \
  -v /var/log/salt:/var/log/salt \
  --restart on-failure:10 \
  --name salt-minion \
  --link redis:redis \
  voxxit/salt minion
```

### Helpful Aliases

Alternatively, replace `salt-master` below for `salt-minion` if that container is running on the server.

```
alias salt="docker exec -it salt-master salt"
alias salt-key="docker exec -it salt-master salt-key"
alias salt-call="docker exec -it salt-master salt-call"
```

**salt-master** Environment variables:

`SALT_INTERFACE` - listening address to bind to in the Docker container
`SALT_STATE_VERBOSE` - be more (`True`) or less (`False`) chatty during state migrations

**salt-minion** Environment variables:

`SALT_MASTER` - hostname/IP of the salt master
`SALT_KEYSIZE` - size of the generated client credentials for a minion
`SALT_MINE_INTERVAL` - how often (in minutes) to collect mine data
