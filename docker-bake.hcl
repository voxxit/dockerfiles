variable "TAG" {
  default = "latest"
}

function "imgref" {
  params = [name, tag]
  result = "docker.io/voxxit/${name}:${tag}"
}

function "dockerfile" {
  params = [name]
  result = "./${name}/Dockerfile"
}

function "contexts" {
  params = [name]
  result = {
    src = "./${name}"
  }
}

group "default" {
  targets = [
    "apt-mirror",
    "bind",
    "consul",
    "goaccess",
    "grunt",
    "haproxy",
    "icecast",
    "jq",
    "liquidsoap",
    "memcached",
    "nginx",
    "nginx-geoip2",
    "nginx-http2",
    "nginx-rtmp",
    "pg",
    "powerdns",
    "redis",
    "rsyslog",
    "swarm",
    "vault"
  ]
}

target "apt-mirror" {
  dockerfile = dockerfile("apt-mirror")
  contexts = contexts("apt-mirror")
  tags = [imgref("apt-mirror", TAG)]
}

target "bind" {
  dockerfile = dockerfile("bind")
  contexts = contexts("bind")
  tags = [imgref("bind", TAG)]
}

target "consul" {
  dockerfile = dockerfile("consul")
  contexts = contexts("consul")
  tags = [imgref("consul", TAG)]
}

target "goaccess" {
  dockerfile = dockerfile("goaccess")
  contexts = contexts("goaccess")
  tags = [imgref("goaccess", TAG)]
}

target "grunt" {
  dockerfile = dockerfile("grunt")
  contexts = contexts("grunt")
  tags = [imgref("grunt", TAG)]
}

target "haproxy" {
  dockerfile = dockerfile("haproxy")
  contexts = contexts("haproxy")
  tags = [imgref("haproxy", TAG)]
}

target "icecast" {
  dockerfile = dockerfile("icecast")
  contexts = contexts("icecast")
  tags = [imgref("icecast", TAG)]
}

target "jq" {
  dockerfile = dockerfile("jq")
  contexts = contexts("jq")
  tags = [imgref("jq", TAG)]
}

target "liquidsoap" {
  dockerfile = dockerfile("liquidsoap")
  contexts = contexts("liquidsoap")
  tags = [imgref("liquidsoap", TAG)]
}

target "memcached" {
  dockerfile = dockerfile("memcached")
  contexts = contexts("memcached")
  tags = [imgref("memcached", TAG)]
}

target "nginx" {
  dockerfile = dockerfile("nginx")
  contexts = contexts("nginx")
  tags = [imgref("nginx", TAG)]
}

target "nginx-geoip2" {
  dockerfile = dockerfile("nginx-geoip2")
  contexts = contexts("nginx-geoip2")
  tags = [imgref("nginx-geoip2", TAG)]
}

target "nginx-http2" {
  dockerfile = dockerfile("nginx-http2")
  contexts = contexts("nginx-http2")
  tags = [imgref("nginx-http2", TAG)]
} 

target "nginx-rtmp" {
  dockerfile = dockerfile("nginx-rtmp")
  contexts = contexts("nginx-rtmp")
  tags = [imgref("nginx-rtmp", TAG)]
}

target "pg" {
  dockerfile = dockerfile("pg")
  contexts = contexts("pg")
  tags = [imgref("pg", TAG)]
}

target "powerdns" {
  dockerfile = dockerfile("powerdns")
  contexts = contexts("powerdns")
  tags = [imgref("powerdns", TAG)]
}

target "redis" {
  dockerfile = dockerfile("redis")
  contexts = contexts("redis")
  tags = [imgref("redis", TAG)]
}

target "rsyslog" {
  dockerfile = dockerfile("rsyslog")
  contexts = contexts("rsyslog")
  tags = [imgref("rsyslog", TAG)]
}

target "swarm" {
  dockerfile = dockerfile("swarm")
  contexts = contexts("swarm")
  tags = [imgref("swarm", TAG)]
}

target "vault" {
  dockerfile = dockerfile("vault")
  contexts = contexts("vault")
  tags = [imgref("vault", TAG)]
}
