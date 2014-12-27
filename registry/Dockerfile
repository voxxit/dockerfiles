FROM voxxit/base:alpine

RUN  apk update \
  && apk add file build-base swig python python-dev py-pip openssl-dev xz-dev libevent-dev git \
  && git clone --depth=1 https://github.com/docker/docker-registry.git /docker-registry \
  && cp /docker-registry/config/boto.cfg /etc/boto.cfg \
  && pip install /docker-registry/depends/docker-registry-core \
  && pip install file:///docker-registry#egg=docker-registry[bugsnag,newrelic,cors] \
  && patch /usr/lib/python2.7/site-packages/boto/connection.py < /docker-registry/contrib/boto_header_patch.diff \
  && apk del file build-base python-dev git \
  && rm -rf /var/cache/apk/*

ENV DOCKER_REGISTRY_CONFIG /config.yml
ENV SETTINGS_FLAVOR production

EXPOSE 5000

CMD [ "docker-registry" ]
