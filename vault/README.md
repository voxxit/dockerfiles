Run a dev server:

```
docker pull quay.io/voxxit/vault:latest
docker run -d --memory-swap=-1 --name vault-dev quay.io/voxxit/vault:latest
```

To run a command:

```
alias vault='docker exec -it vault-dev vault "$@"'

vault write -address=http://127.0.0.1:8200 secret/hello value=world
Success! Data written to: secret/hello

vault read -address=http://127.0.0.1:8200 secret/hello value=world
Key            	Value
lease_id       	secret/hello/ced98ef0-18d4-a5b0-8d49-3eee5aa0dfae
lease_duration 	2592000
lease_renewable	false
value          	world
```
