FROM voxxit/base:alpine

RUN apk update \
  && apk add \
    git linux-headers gcc libc-dev openssl-dev swig python python-dev py-pip \
    py-yaml py-jinja2 py-hiredis py-simplejson zeromq zeromq-dev libffi-dev \
  && pip install msgpack-python apache-libcloud requests \
    pyzmq pycrypto m2crypto psutil docker-py python-etcd redis \
    pygit \
  && pip install salt \
  && rm -rf /root/.pip /var/cache/apk/*

COPY ./minion.sh /usr/local/bin/minion
COPY ./master.sh /usr/local/bin/master

VOLUME [ "/etc/salt", "/var/cache/salt", "/var/log/salt", "/srv/salt" ]

# salt-master
EXPOSE 4505/tcp 4506/tcp

CMD [ "salt" ]
