FROM voxxit/base:ubuntu

RUN  apt-get update \
  && apt-get install -y --no-install-recommends wig python-pip python-dev libssl-dev liblzma-dev libevent1-dev git-core \
  && rm -rf /var/lib/apt/lists/* \
  && git clone --depth=1 https://github.com/docker/docker-registry.git /docker-registry \
  && cp /docker-registry/config/boto.cfg /etc/boto.cfg \
  && pip install /docker-registry/depends/docker-registry-core \
  && pip install file:///docker-registry#egg=docker-registry[bugsnag,newrelic,cors] \
  && patch $(python -c 'import boto; import os; print os.path.dirname(boto.__file__)')/connection.py < /docker-registry/contrib/boto_header_patch.diff

ENV DOCKER_REGISTRY_CONFIG /config.yml
ENV SETTINGS_FLAVOR production

EXPOSE 5000

CMD [ "docker-registry" ]
