FROM alpine

RUN  apk add --no-cache bash perl gettext wget ca-certificates unzip \
  && mkdir -p /usr/src \
  && cd /usr/src \
  && wget https://github.com/apt-mirror/apt-mirror/archive/master.zip \
  && unzip master.zip \
  && install -m 755 -D apt-mirror-master/apt-mirror /usr/local/bin/apt-mirror \
  && rm -rf apt-mirror* master.zip

ENV BASE_PATH		/var/spool/apt-mirror
ENV MIRROR_PATH		${BASE_PATH}/mirror
ENV SKEL_PATH		${BASE_PATH}/skel
ENV VAR_PATH		${BASE_PATH}/var
ENV POSTMIRROR_SCRIPT	${VAR_PATH}/post-mirror.sh
ENV RUN_POSTMIRROR	1
ENV NTHREADS		20
ENV TILDE		0
ENV UNLINK		1
ENV USE_PROXY		off
ENV HTTP_PROXY		127.0.0.1:3126
ENV PROXY_USER		user
ENV PROXY_PASSWORD	password

# Can be http or ftp
ENV MIRROR_PROTO 	http

# Choose a local mirror containing _both_ distros (see below)
ENV MIRROR_HOST		archive.ubuntu.com

# Space-separated list of...
ENV MIRROR_DISTROS	"ubuntu"
ENV MIRROR_FLAVORS	"trusty"
ENV MIRROR_BRANCHES	"security updates proposed backports"
ENV MIRROR_COMPONENTS	"main restricted universe multiverse"

ENV MIRROR_LIMIT_RATE	10m

# How long to sleep for until the next mirror
ENV SLEEP_SECS		3600

VOLUME ["${BASE_PATH}"]

COPY resources/apt/mirror.list.template /etc/apt/
COPY resources/apt/post-mirror.sh ${VAR_PATH}/
COPY resources/docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
