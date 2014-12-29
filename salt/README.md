To start a master:

```
docker run \
  -d \
  -p 4505:4505/tcp \
  -p 4506:4506/tcp \
  -v /dev/log:/dev/log \
  -v /etc/salt:/etc/salt \
  -v /srv/salt:/srv/salt \
  -v /var/log/salt:/var/log/salt \
  -v /var/cache/salt:/var/cache/salt \
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
  -v /var/cache/salt:/var/cache/salt \
  --restart on-failure:10 \
  --name salt-minion \
  --link redis:redis \
  voxxit/salt minion
```

### Helpful Aliases

The following aliases assume you're running them on a machine with the salt-minion config above. Alternatively, replace `salt-minion` below for `salt-master` if that container is running on the server.

```
alias salt="docker exec -it salt-minion salt"
alias salt-api="docker exec -it salt-minion salt-api"
alias salt-key="docker exec -it salt-minion salt-key"
alias salt-call="docker exec -it salt-minion salt-call"
alias salt-cp="docker exec -it salt-minion salt-cp"
alias salt-run="docker exec -it salt-minion salt-run"
```

Add these to your `.bashrc` or `.zshrc` file

**salt-master** Environment variables:

`SALT_INTERFACE` - listening address to bind to in the Docker container
`SALT_STATE_VERBOSE` - be more (`True`) or less (`False`) chatty during state migrations

**salt-minion** Environment variables:

`SALT_MASTER` - hostname/IP of the salt master
`SALT_KEYSIZE` - size of the generated client credentials for a minion
`SALT_MINE_INTERVAL` - how often (in minutes) to collect mine data
